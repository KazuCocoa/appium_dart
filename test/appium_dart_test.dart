import 'package:test/test.dart';

import 'package:appium_dart/io.dart';

void main() {
  var driver;

  setUp(() {
    driver = createDriver(uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
      desired: {
        'platformName': 'ios',
        'platformVersion': '12.2',
        'deviceName': 'iPhone 8',
        'browserName': 'Safari',
        'automationName': 'xcuitest'
      });
  });

  tearDown(() {
    driver.quit();
  });

  test('connect to server', () {
    assert(driver.title == 'Appium/welcome');
  });
}
