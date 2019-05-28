import 'package:test/test.dart';

import 'package:appium_dart/async_io.dart';
export 'package:appium_dart/src/async/web_element.dart';

void main() {
  AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
      desired: {
        'platformName': 'ios',
        'platformVersion': '12.2',
        'deviceName': 'iPhone 8',
        'browserName': 'Safari',
        'automationName': 'xcuitest'
      });
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('connect to server', () async {
    expect(await driver.title, 'Appium/welcome');
  });

  test('connect to existing session', () async {
    var sessionId = driver.id;

    AppiumWebDriver newDriver = await fromExistingSession(sessionId);
    expect(await newDriver.title, 'Appium/welcome');
    expect(newDriver.id, sessionId);
  });

  test('find by appium element', () async {
    try {
      await driver.findElement(AppiumBy.accessibilityId('Appium/welcome'));
      throw 'expected Unsupported locator strategy: accessibility id error';
    } on UnknownException catch (e) {
      expect(e.message.contains('Unsupported locator strategy: accessibility id'), true);
    }
  });
}
