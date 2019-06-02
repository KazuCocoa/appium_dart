import 'package:test/test.dart';

import 'dart:io';

import 'package:appium_dart/async_io.dart';

void main() {
  AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        desired: {
          'app': '${Directory.current.path}/test/functional/app/UICatalog.app.zip',
          'platformName': 'ios',
          'platformVersion': '12.2',
          'deviceName': 'iPhone 8',
          'automationName': 'xcuitest'
        });
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('Click a button', () async {
    var element = await driver.findElement(AppiumBy.accessibilityId('Buttons'));
    await element.click();

    await driver.findElement(AppiumBy.name('Gray'));
    await driver.back();

    await driver.findElement(AppiumBy.accessibilityId('TextView'));
  });
}
