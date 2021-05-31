import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Session {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Session(this._client, this._handler);

  /// Get sessions
  ///
  /// ```dart
  /// driver.session.getCapabilities()
  /// ```
  Future<Map<String, dynamic>> getCapabilities() => _client.send(
      _handler.session.buildGetCapabilitiesRequest(),
      _handler.session.parseGetCapabilitiesResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Session &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.session($_client)';
}
