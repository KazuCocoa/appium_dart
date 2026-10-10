import 'dart:convert';

import 'package:appium_driver/async_core.dart' show NoSuchElementException;
import 'package:appium_driver/src/handler/w3c/device.dart';
import 'package:appium_driver/src/handler/w3c/element.dart';
import 'package:appium_driver/src/handler/w3c/logs.dart';
import 'package:test/test.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

void main() {
  group('element displayed', () {
    for (final displayed in [true, false]) {
      test('returns $displayed from the server', () {
        final response =
            WebDriverResponse(200, 'OK', jsonEncode({'value': displayed}));
        expect(W3cElementHandler().parseDisplayedResponse(response), displayed);
      });
    }

    test('propagates protocol errors', () {
      final response = WebDriverResponse(
          404,
          'Not Found',
          jsonEncode({
            'value': {
              'error': 'no such element',
              'message': 'Element not found'
            }
          }));
      expect(() => W3cElementHandler().parseDisplayedResponse(response),
          throwsA(isA<NoSuchElementException>()));
    });
  });

  group('event filters', () {
    test('sends the requested event type', () {
      final request =
          W3cLogsHandler().buildGetEventsRequest(type: 'vendor:event');
      expect(request.method, HttpMethod.httpPost);
      expect(request.uri, 'appium/events');
      expect(jsonDecode(request.body!), {'type': 'vendor:event'});
    });

    test('omits the filter when no type is supplied', () {
      final request = W3cLogsHandler().buildGetEventsRequest();
      expect(jsonDecode(request.body!), isEmpty);
    });
  });

  group('start activity intent flags', () {
    for (final waitPackage in [null, 'com.example']) {
      test('sends flags with appWaitPackage=$waitPackage', () {
        final request = W3cDeviceHandler().buildStartActivityRequest(
          appPackage: 'com.example',
          appActivity: 'MainActivity',
          appWaitPackage: waitPackage,
          intentFlags: '0x10000000',
        );
        expect(jsonDecode(request.body!)['intentFlags'], '0x10000000');
      });

      test('omits absent flags with appWaitPackage=$waitPackage', () {
        final request = W3cDeviceHandler().buildStartActivityRequest(
          appPackage: 'com.example',
          appActivity: 'MainActivity',
          appWaitPackage: waitPackage,
        );
        expect(jsonDecode(request.body!), isNot(contains('intentFlags')));
      });
    }
  });
}
