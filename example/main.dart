import 'dart:convert';
import 'dart:io';

import 'package:appium_driver/async_io.dart';
import 'package:test/test.dart';

void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: Uri.parse('http://127.0.0.1:4723/wd/hub/'),
        desired: {
          'platformName': 'android',
          'udid': 'D0AA002182JC0202126',
          'deviceName': 'android',
          'automationName': 'flutter',
          'app': 'https://github.com/KazuCocoa/my_flutter_app3/blob/main/apps/android-debug/app-debug.apk?raw=true'
        });
  });

  tearDownAll(() async {
    await driver.quit();
  });

  // test('connect to server', () async {
  //   expect(await driver.title, 'Appium/welcome');
  // });
  //
  // test('connect to existing session', () async {
  //   var sessionId = driver.id;
  //
  //   AppiumWebDriver newDriver = await fromExistingSession(sessionId);
  //   expect(await newDriver.title, 'Appium/welcome');
  //   expect(newDriver.id, sessionId);
  // });

  // test('find by appium element', () async {
  //   final title = 'Appium/welcome';
  //   try {
  //     await driver.findElement(AppiumBy.accessibilityId(title));
  //     throw 'expected Unsupported locator strategy: accessibility id error';
  //   } on UnknownException catch (e) {
  //     expect(
  //         e.message!.contains('Unsupported locator strategy: accessibility id'),
  //         true);
  //   }
  // });

  test('find by appium element with flutter driver', () async {
    final title = 'Appium/welcome';
    try {
      var finder = base64.encode(utf8.encode(json.encode({
        "finderType": "ByValueKey",
        "keyValueString": "increment",
        "keyValueType": "String"
      }).toString()));
      var element = driver.getElement(finder);
      await element.click();

      sleep(Duration(seconds: 5));
    } on UnknownException catch (e) {
      expect(
          e.message!.contains('Unsupported locator strategy: accessibility id'),
          true);
    }
  });
}
