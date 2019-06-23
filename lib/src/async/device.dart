import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Device {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Device(this._client, this._handler);

  /// Get is device locked
  Future<bool> isLocked() => _client.send(
      _handler.device.buildDeviceIsLockedRequest(),
      _handler.device.parseDeviceIsLocked);

  /// Get lock device
  Future<void> lock({Duration seconds}) => _client.send(
      _handler.device.buildLockDeviceRequest(seconds: seconds),
      _handler.device.parseLockDevice);


  /// Get app state
  Future<void> unlock() => _client.send(
      _handler.device.buildUnlockDeviceRequest(),
      _handler.device.parseUnlockDevice);


  /// Get app state
  Future<String> getSystemTime() => _client.send(
      _handler.device.buildDeviceSystemTimeRequest(),
      _handler.device.parseDeviceSystemTime);


  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Device &&
      other._client == this._client &&
      other._handler == this._handler;

  @override
  String toString() => '$_handler.appState($_client)';
}
