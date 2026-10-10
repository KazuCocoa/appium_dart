import 'package:appium_driver/async_core.dart' as core;
import 'package:appium_driver/src/handler/w3c_handler.dart';
import 'package:test/test.dart';

import 'support/recording_client.dart';

void main() {
  test('creates sessions at the root and releases the temporary client',
      () async {
    final clients = <RecordingClient>[];
    final driver = await core.createDriver((uri) {
      final client = RecordingClient(
          uri,
          (_) => response({
                'sessionId': 'abc',
                'capabilities': <String, dynamic>{},
              }));
      clients.add(client);
      return client;
    }, desired: {});
    expect(
        clients.first.urls.single, Uri.parse('http://127.0.0.1:4723/session'));
    expect(clients.first.closeCount, 1);
    expect(clients.last.closeCount, 0);
    await driver.quit(closeSession: false);
    expect(clients.last.closeCount, 1);
  });

  test('releases the creation client after a server error', () async {
    final client = RecordingClient(core.defaultUri,
        (_) => errorResponse('session not created', status: 500));
    await expectLater(core.createDriver((_) => client, desired: {}),
        throwsA(isA<core.SessionNotCreatedException>()));
    expect(client.closeCount, 1);
  });

  test('releases the creation client after a transport error', () async {
    final client =
        RecordingClient(core.defaultUri, (_) => throw StateError('Offline'));
    await expectLater(
        core.createDriver((_) => client, desired: {}), throwsStateError);
    expect(client.closeCount, 1);
  });

  test('attachment releases its temporary client', () async {
    final clients = <RecordingClient>[];
    final driver = await core.fromExistingSession((uri) {
      final client = RecordingClient(uri, (_) => response(null));
      clients.add(client);
      return client;
    }, 'abc');
    expect(clients.first.closeCount, 1);
    expect(clients.last.closeCount, 0);
    await driver.quit(closeSession: false);
  });

  test('rejects JSON Wire before creating any clients', () async {
    var allocations = 0;
    RecordingClient factory(Uri uri) {
      allocations++;
      return RecordingClient(uri, (_) => response(null));
    }

    final unsupported = throwsA(isA<UnsupportedError>()
        .having((e) => e.message, 'message', contains('JSON Wire')));
    await expectLater(
        core.createDriver(factory,
            desired: {}, spec: core.WebDriverSpec.JsonWire),
        unsupported);
    await expectLater(
        core.fromExistingSession(factory, 'abc',
            spec: core.WebDriverSpec.JsonWire),
        unsupported);
    expect(
        () => core.fromExistingSessionSync(
            factory, 'abc', core.WebDriverSpec.JsonWire),
        unsupported);
    expect(allocations, 0);
  });

  for (final failing in [false, true]) {
    test('status uses and closes a fresh client per call, failing=$failing',
        () async {
      final clients = <RecordingClient>[];
      final status = core.Status(core.defaultUri, W3cWebDriverHandler(),
          createRequestClient: (uri) {
        final client = RecordingClient(
            uri,
            (_) => failing
                ? errorResponse('unknown error', status: 500)
                : response({'ready': true}));
        clients.add(client);
        return client;
      });
      for (var i = 0; i < 2; i++) {
        if (failing) {
          await expectLater(
              status.get(), throwsA(isA<core.UnknownException>()));
        } else {
          expect(await status.get(), {'ready': true});
        }
      }
      expect(clients.length, 2);
      expect(clients.every((client) => client.closeCount == 1), isTrue);
    });
  }
}
