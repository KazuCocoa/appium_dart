import 'package:test/test.dart';

import 'package:appium_dart/appium_dart.dart';

void main() {
  test('connect to server', () {
    var driver = createDriver(uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        desired: {
          'platformName': 'ios',
          'platformVersion': '12.2',
          'deviceName': 'iPhone 8',
          'browserName': 'Safari',
          'automationName': 'xcuitest'
    });
    assert(driver != null);

    driver.quit();
  });
}
