import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class AppManagement {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  AppManagement(this._client, this._handler);

  /// activate the app
  Future<void> activate(String appId) => _client.send(
      _handler.app.buildActivateAppRequest(appId),
      _handler.app.parseActivateAppResponse);

  /// go to background the app
  Future<void> background({Duration? seconds}) => _client.send(
      _handler.app.buildBackgroundAppRequest(seconds: seconds),
      _handler.app.parseBackgroundAppResponse);

  Future<void> close() => _client.send(
      _handler.app.buildCloseAppRequest(), _handler.app.parseCloseAppResponse);

  Future<void> install(String path,
          {bool? replace,
          Duration? timeout,
          bool? allowTestPackage,
          bool? useSdcard,
          bool? grantPermissions}) =>
      _client.send(
          _handler.app.buildInstallAppRequest(path,
              replace: replace,
              timeout: timeout,
              allowTestPackage: allowTestPackage,
              useSdcard: useSdcard,
              grantPermissions: grantPermissions),
          _handler.app.parseInstallAppResponse);

  Future<bool> isInstalled(String appId) => _client.send(
      _handler.app.buildIsAppInstalledRequest(appId),
      _handler.app.parseIsAppInstalledResponse);

  Future<void> launch() => _client.send(_handler.app.buildLaunchAppRequest(),
      _handler.app.parseLaunchAppResponse);

  Future<void> remove(String appId, {bool? keepData, Duration? timeout}) =>
      _client.send(
          _handler.app.buildRemoveAppRequest(appId,
              keepData: keepData, timeout: timeout),
          _handler.app.parseRemoveAppResponse);

  Future<void> reset() => _client.send(
      _handler.app.buildResetAppRequest(), _handler.app.parseResetAppResponse);

  Future<void> terminate(String appId) => _client.send(
      _handler.app.buildTerminateAppRequest(appId),
      _handler.app.parseTerminateResponse);

  Future<Map<String, dynamic>> string() => _client.send(
      _handler.app.buildGetStringRequest(),
      _handler.app.parseGetStringResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is AppManagement &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.appManagemenet($_client)';
}
