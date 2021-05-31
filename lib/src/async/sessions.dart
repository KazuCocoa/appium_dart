import 'dart:async';

import 'package:appium_driver/async_io.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Sessions {
  AsyncRequestClient? _client;
  AppiumWebDriverHandler? _handler;

  Sessions(Uri baseUrl, AppiumWebDriverHandler handler) {
    _client = AsyncIoRequestClient(baseUrl);
    _handler = handler;
  }

  /// Get sessions
  ///
  /// ```dart
  /// driver.sessions.get()
  /// //=> [
  /// // {"id":"3ec13c12-9199-4d03-ba8c-51925d184316",
  /// //   "capabilities":{"platformName":"iOS","browserName":"Safari",
  /// //   "platformVersion":"12.2","deviceName":"iPhone 8",
  /// //   "automationName":"xcuitest","wdaLocalPort":8101,
  /// //   "useJSONSource":true,"reduceMotion":true}}]
  /// ```
  Future<List<dynamic>> get() => _client!.send(
      _handler!.sessions.buildGetRequest(),
      _handler!.sessions.parseGetResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Sessions &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.sessions($_client)';
}
