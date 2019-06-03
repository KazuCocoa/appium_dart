import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Timeouts {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Timeouts(this._client, this._handler);

  /// Sets the script timeout.
  Future<void> setScriptTimeout(Duration duration) => _client.send(
      _handler.timeouts.buildSetScriptTimeoutRequest(duration),
      _handler.timeouts.parseSetScriptTimeoutResponse);

  /// Sets the implicit timeout.
  Future<void> setImplicitTimeout(Duration duration) => _client.send(
      _handler.timeouts.buildSetImplicitTimeoutRequest(duration),
      _handler.timeouts.parseSetImplicitTimeoutResponse);

  /// Sets the page load timeout.
  Future<void> setPageLoadTimeout(Duration duration) => _client.send(
      _handler.timeouts.buildSetPageLoadTimeoutRequest(duration),
      _handler.timeouts.parseSetPageLoadTimeoutResponse);

  @override
  String toString() => '$_handler.timeouts($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Timeouts &&
      _handler == other._handler &&
      _client == other._client;
}
