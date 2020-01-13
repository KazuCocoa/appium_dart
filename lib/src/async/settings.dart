import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Settings {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Settings(this._client, this._handler);

  /// Get settings
  Future<dynamic> get() => _client.send(
      _handler.settings.buildGetSettingsRequest(),
      _handler.settings.parseGetSettingsResponse);

  /// Update settings
  Future<void> update(Map<String, dynamic> items) => _client.send(
      _handler.settings.buildUpdateSettingsRequest(items),
      _handler.settings.parseUpdateSettingsResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Settings &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.settings($_client)';
}
