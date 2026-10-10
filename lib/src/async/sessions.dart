import 'dart:async';

import 'package:appium_driver/src/async/legacy_request.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

import 'package:appium_driver/async_io.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Sessions {
  final Uri _baseUrl;
  final AppiumWebDriverHandler _handler;
  final AsyncRequestClient Function(Uri) _createRequestClient;

  Sessions(this._baseUrl, this._handler,
      {AsyncRequestClient Function(Uri)? createRequestClient})
      : _createRequestClient = createRequestClient ?? AsyncIoRequestClient.new;

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
  Future<List<dynamic>> get() async {
    final client = _createRequestClient(_baseUrl);
    try {
      return await sendWithLegacyFallback(
          client,
          _handler.sessions.buildGetRequest(),
          WebDriverRequest.getRequest('sessions'),
          _handler.sessions.parseGetResponse);
    } finally {
      client.close();
    }
  }

  @override
  int get hashCode => Object.hash(_baseUrl, _handler, _createRequestClient);

  @override
  bool operator ==(other) =>
      other is Sessions &&
      other._baseUrl == _baseUrl &&
      other._createRequestClient == _createRequestClient &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.sessions($_baseUrl)';
}
