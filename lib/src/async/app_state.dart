import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:appium_driver/src/common/app_state.dart' as app_state_enum;

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class AppState {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  AppState(this._client, this._handler);

  /// Get app state
  Future<app_state_enum.AppState> get(String appId) => _client.send(
      _handler.appState.buildGetAppStateRequest(appId),
      _handler.appState.parseGetAppState);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is AppState &&
      other._client == this._client &&
      other._handler == this._handler;

  @override
  String toString() => '$_handler.appState($_client)';
}
