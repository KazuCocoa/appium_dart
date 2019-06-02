library appium_dart.async_core_test;

import 'package:test/test.dart';
import 'package:appium_dart/async_core.dart' as core;

void main() {
  group('add_appium_prefix', () {
    test('should add appium prefix', () {
      expect(core.addAppiumPrefix(
        {
          'platformName': 'ios',
          'platformVersion': '12.2',
          'deviceName': 'iPhone 8',
          'browserName': 'Safari',
          'automationName': 'xcuitest'
        }
      ), {
      'platformName': 'ios',
      'appium:platformVersion': '12.2',
      'appium:deviceName': 'iPhone 8',
      'browserName': 'Safari',
      'appium:automationName': 'xcuitest'
      });
    });
  });

}
