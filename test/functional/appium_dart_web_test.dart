import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.iOSDesiredCapabilitiesWeb);
  });

  tearDownAll(() async {
    await driver.quit();
  });

  group('connect', () {
    test('connect to server', () async {
      expect(await driver.title, 'Appium/welcome');
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
      var result = await driver.contexts.getAvailableContexts();
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
      await driver.app.background(seconds: Duration(seconds: -1));
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
      await driver.findElement(AppiumBy.accessibilityId(title));
      throw 'expected Unsupported locator strategy: accessibility id error';
    } on UnknownException catch (e) {
      expect(
          e.message.contains('Unsupported locator strategy: accessibility id'),
          true);
    }
  });
}
