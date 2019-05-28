import 'package:test/test.dart';

import 'package:appium_dart/async_io.dart';
import 'package:appium_dart/src/driver.dart';

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
    assert(await driver.title == 'Appium/welcome');
  });

  test('connect to existing session', () async {
    var sessionId = driver.id;

    AppiumWebDriver newDriver = await fromExistingSession(sessionId);
    assert(await newDriver.title == 'Appium/welcome');
    assert(sessionId == newDriver.id);

  });
}
