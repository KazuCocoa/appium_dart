import 'dart:convert';

import 'package:appium_driver/async_core.dart' as core;
import 'package:appium_driver/src/handler/w3c_handler.dart';
import 'package:test/test.dart';

import 'support/recording_client.dart';

void main() {
  for (final legacyError in [null, 'unknown command', 'unknown method']) {
    test('sessions endpoint negotiation: $legacyError', () async {
      final clients = <RecordingClient>[];
      final sessions = core.Sessions(core.defaultUri, W3cWebDriverHandler(),
          createRequestClient: (uri) {
        final client = RecordingClient(uri, (request) {
          if (legacyError != null && request.uri == 'appium/sessions') {
            return errorResponse(legacyError);
          }
          return response([
            {'id': 'abc', 'capabilities': {}}
          ]);
        });
        clients.add(client);
        return client;
      });
      for (var i = 0; i < 2; i++) {
        expect((await sessions.get()).single['id'], 'abc');
      }
      expect(clients.length, 2);
      for (final client in clients) {
        expect(
            client.requests.map((r) => r.uri),
            legacyError == null
                ? ['appium/sessions']
                : ['appium/sessions', 'sessions']);
        expect(client.closeCount, 1);
      }
    });

    test('log endpoint negotiation: $legacyError', () async {
      final client = RecordingClient(core.defaultUri, (request) {
        if (legacyError != null && request.uri!.startsWith('se/')) {
          return errorResponse(legacyError);
        }
        return response(request.uri!.endsWith('types')
            ? ['logcat']
            : [
                {'message': 'hello', 'timestamp': 1000, 'level': 'INFO'}
              ]);
      });
      final logs = core.Logs(client, W3cWebDriverHandler());
      expect(await logs.getAvailableType(), ['logcat']);
      expect((await logs.get('logcat').toList()).single.message, 'hello');
      expect(
          client.requests.map((r) => r.uri),
          legacyError == null
              ? ['se/log/types', 'se/log']
              : ['se/log/types', 'log/types', 'se/log', 'log']);
      for (final request in client.requests.where((r) => r.body != null)) {
        expect(jsonDecode(request.body!), {'type': 'logcat'});
      }
    });
  }

  for (final error in [
    'unknown error',
    'invalid session id',
    'invalid argument'
  ]) {
    test('does not retry sessions on $error and still closes the client',
        () async {
      final client = RecordingClient(
          core.defaultUri, (_) => errorResponse(error, status: 500));
      final sessions = core.Sessions(core.defaultUri, W3cWebDriverHandler(),
          createRequestClient: (_) => client);
      await expectLater(
          sessions.get(), throwsA(isA<core.WebDriverException>()));
      expect(client.requests.length, 1);
      expect(client.closeCount, 1);
    });

    test('does not retry log requests on $error', () async {
      final client = RecordingClient(
          core.defaultUri, (_) => errorResponse(error, status: 500));
      final logs = core.Logs(client, W3cWebDriverHandler());
      await expectLater(
          logs.getAvailableType(), throwsA(isA<core.WebDriverException>()));
      await expectLater(
          logs.get('logcat').toList(), throwsA(isA<core.WebDriverException>()));
      expect(client.requests.map((r) => r.uri), ['se/log/types', 'se/log']);
    });
  }

  test('preserves a forbidden session discovery response', () async {
    final client = RecordingClient(
        core.defaultUri, (_) => errorResponse('unknown error', status: 403));
    final sessions = core.Sessions(core.defaultUri, W3cWebDriverHandler(),
        createRequestClient: (_) => client);
    await expectLater(
        sessions.get(),
        throwsA(isA<core.WebDriverException>()
            .having((e) => e.statusCode, 'status', 403)));
    expect(client.requests.length, 1);
    expect(client.closeCount, 1);
  });
}
