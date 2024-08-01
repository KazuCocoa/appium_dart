import 'dart:io';

class TestHelper {
  static var localServer = Uri.parse('http://127.0.0.1:4723/');

  static var androidDesiredCapabilitiesApp = {
    'platformName': 'Android',
    'app': File('test/functional/app/api.apk.zip').absolute.path,
    'deviceName': 'Android',
    'automationName': 'UiAutomator2',
    'appPackage': 'io.appium.android.apis',
    'appActivity': 'io.appium.android.apis.ApiDemos',
    'unicodeKeyboard': true,
    'resetKeyboard': true,
    'disableWindowAnimation': true,
    'autoGrantPermissions': true,
    'language': 'en',
    'locale': 'US',
  };

  static var iOSDesiredCapabilitiesApp = {
    'platformName': 'iOS',
    'platformVersion': '17.4',
    'app': File('test/functional/app/UICatalog.app.zip').absolute.path,
    'deviceName': 'iPhone 15 Plus', // Runs tests in parallel per file by default
    'automationName': 'xcuitest',
    'wdaLocalPort': 8100,
    'useJSONSource': true,
    'reduceMotion': true
  };

  static var iOSDesiredCapabilitiesWeb = {
    'platformName': 'iOS',
    'platformVersion': '17.4',
    'browserName': 'Safari',
    'deviceName': 'iPhone 15 Plus', // Runs tests in parallel per file by default
    'automationName': 'xcuitest',
    'wdaLocalPort': 8101,
    'useJSONSource': true,
    'reduceMotion': true
  };
}
