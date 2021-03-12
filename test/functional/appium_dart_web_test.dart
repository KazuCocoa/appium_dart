import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.iOSDesiredCapabilitiesWeb);
  });

  tearDownAll(() async {
    await driver.quit();
  });

  group('connect', () {
    test('connect to server and get sessions', () async {
      expect(await driver.title, 'Appium/welcome');
      var result = await (driver.sessions.get());
      // The value could be over 1 in parallel session
      expect(result.isNotEmpty, true);
      var ok = false;
      for (var r in result) {
        if (driver.id == r['id']) {
          ok = true;
          break;
        }
      }
      expect(ok, true);
    });

    test('connect to existing session', () async {
      var sessionId = driver.id;

      AppiumWebDriver newDriver = await fromExistingSession(sessionId);
      expect(await newDriver.title, 'Appium/welcome');
      expect(newDriver.id, sessionId);
      expect(AppState.RunningInForeground,
          await newDriver.appState.get('com.apple.mobilesafari'));
    });
  });

  group('capabilities', () {
    test('Get capabilities', () async {
      var result = await (driver.contexts.getAvailableContexts());
      expect((await driver.contexts.getCurrentContext()).startsWith('WEBVIEW'),
          true);
      await driver.contexts.setContext(result.first);
      expect(await driver.contexts.getCurrentContext(), 'NATIVE_APP');
      await driver.contexts.setContext(result.last);
      expect((await driver.contexts.getCurrentContext()).startsWith('WEBVIEW'),
          true);
    });
  });

  group('devices', () {
    test('app management', () async {
      expect(await driver.app.isInstalled('com.apple.mobilesafari'), true);
      await driver.app.background(seconds: const Duration(seconds: -1));
      expect(await driver.appState.get('com.apple.mobilesafari'),
          AppState.RunningInBackground);
      await driver.app.activate('com.apple.mobilesafari');
      expect(await driver.appState.get('com.apple.mobilesafari'),
          AppState.RunningInForeground);
      await driver.app.terminate('com.apple.mobilesafari');
      expect(await driver.appState.get('com.apple.mobilesafari'),
          AppState.NotRunning);
      await driver.app.launch();
      expect(await driver.appState.get('com.apple.mobilesafari'),
          AppState.RunningInForeground);
    });
  });

  test('find by appium element', () async {
    final title = 'Appium/welcome';
    try {
      var e = await driver.findElement(AppiumBy.accessibilityId(title));
      // ignore: unnecessary_null_comparison
      expect(e.id != null, true);
      throw 'expected Unsupported locator strategy: accessibility id error';
    } on UnknownException catch (e) {
      expect(
          e.message!.contains('Unsupported locator strategy: accessibility id'),
          true);
    }
  });

  test('find by element', () async {
    final h1 = '//h1';
    var e = await driver.findElement(AppiumBy.xpath(h1));
    // ignore: unnecessary_null_comparison
    expect(e.id != null, true);
    expect(await e.text, "Let's browse!");
  });
}
