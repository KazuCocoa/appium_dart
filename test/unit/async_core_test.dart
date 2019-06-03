library appium_driver.async_core_test;

import 'package:test/test.dart';
import 'package:appium_driver/async_core.dart' as core;

void main() {
  group('add_appium_prefix', () {
    test('should add appium prefix', () {
      expect(
          core.addAppiumPrefix({
            'platformName': 'ios',
            'platformVersion': '12.2',
            'deviceName': 'iPhone 8',
            'browserName': 'Safari',
            'automationName': 'xcuitest'
          }),
          {
            'platformName': 'ios',
            'appium:platformVersion': '12.2',
            'appium:deviceName': 'iPhone 8',
            'browserName': 'Safari',
            'appium:automationName': 'xcuitest'
          });
    });
  });

  group('directConnect', () {
    test('should apply directConnects', () {
      expect(
          core.updateUriWithDirectConnect(core.defaultUri, {
            'deviceName': 'xxxxxxxxx',
            'directConnectProtocol': 'https',
            'directConnectHost': 'example.com',
            'directConnectPort': 8000,
            'directConnectPath': '/example/wd/hub',
            'udid': 'yyyyyyyy'
          }),
          Uri.parse('https://example.com:8000/example/wd/hub'));
    });
    test('should return the default uri', () {
      expect(
          core.updateUriWithDirectConnect(core.defaultUri, {
            'deviceName': 'xxxxxxxxx',
            'directConnectProtocol': 'https',
            'directConnectPort': 8000,
            'directConnectPath': '/example/wd/hub',
            'udid': 'yyyyyyyy'
          }),
          core.defaultUri);
    });
  });
}
