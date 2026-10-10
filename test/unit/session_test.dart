import 'dart:convert';

import 'package:appium_driver/async_core.dart' as core;
import 'package:appium_driver/async_io.dart' as io;
import 'package:test/test.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class _SessionClient extends AsyncRequestClient {
  final Map<String, dynamic> capabilities;
  final List<Uri> requests;

  _SessionClient(super.prefix, this.capabilities, this.requests);

  @override
  Future<WebDriverResponse> sendRaw(WebDriverRequest request) async {
    requests.add(resolve(request.uri!));
    final Object value = request.uri == 'session'
        ? {'sessionId': 'abc', 'capabilities': capabilities}
        : 'Example title';
    return WebDriverResponse(200, 'OK', jsonEncode({'value': value}));
  }
}

void main() {
  group('Direct Connect requests', () {
    for (final path in ['/wd/hub', '/wd/hub/', '', '/']) {
      test('preserves the base path "$path" after session creation', () async {
        final requests = <Uri>[];
        final capabilities = <String, dynamic>{
          'directConnectProtocol': 'https',
          'directConnectHost': 'example.com',
          'directConnectPort': 8443,
          'directConnectPath': path,
        };
        final driver = await core.createDriver(
          (uri) => _SessionClient(uri, capabilities, requests),
          desired: {},
        );

        expect(await driver.title, 'Example title');
        final basePath = path.startsWith('/wd/hub') ? '/wd/hub/' : '/';
        expect(requests.last,
            Uri.parse('https://example.com:8443${basePath}session/abc/title'));
      });
    }

    test('keeps the original server without Direct Connect capabilities',
        () async {
      final requests = <Uri>[];
      final driver = await core.createDriver(
        (uri) => _SessionClient(uri, {}, requests),
        uri: Uri.parse('http://localhost:4723/custom/'),
        desired: {},
      );

      await driver.title;
      expect(requests.last,
          Uri.parse('http://localhost:4723/custom/session/abc/title'));
    });
  });

  group('fromExistingSession', () {
    test('routes commands using supplied Direct Connect capabilities',
        () async {
      final requests = <Uri>[];
      final capabilities = <String, dynamic>{
        'directConnectProtocol': 'https',
        'directConnectHost': 'example.com',
        'directConnectPort': 8443,
        'directConnectPath': '/wd/hub',
      };
      final driver = await core.fromExistingSession(
        (uri) => _SessionClient(uri, {}, requests),
        'abc',
        capabilities: capabilities,
      );

      expect(await driver.title, 'Example title');
      expect(requests.single,
          Uri.parse('https://example.com:8443/wd/hub/session/abc/title'));
      expect(driver.capabilities, capabilities);
    });

    test('retains supplied capabilities through the public IO API', () async {
      final capabilities = {'platformName': 'Android'};
      final driver =
          await io.fromExistingSession('abc', capabilities: capabilities);

      expect(driver.id, 'abc');
      expect(driver.capabilities, capabilities);
      expect(() => driver.capabilities['platformName'] = 'iOS',
          throwsUnsupportedError);
    });

    test('can attach without supplied capabilities', () async {
      final driver = await io.fromExistingSession('abc');

      expect(driver.id, 'abc');
      expect(driver.capabilities, isEmpty);
    });
  });
}
