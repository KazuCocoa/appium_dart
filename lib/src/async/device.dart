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
      _handler.device.parseDeviceIsLockedResponse);

  /// Get lock device
  Future<void> lock({Duration seconds}) => _client.send(
      _handler.device.buildLockDeviceRequest(seconds: seconds),
      _handler.device.parseLockDeviceResponse);

  /// Get app state
  Future<void> unlock() => _client.send(
      _handler.device.buildUnlockDeviceRequest(),
      _handler.device.parseUnlockDeviceResponse);

  /// Get app state
  Future<String> getSystemTime() => _client.send(
      _handler.device.buildDeviceSystemTimeRequest(),
      _handler.device.parseDeviceSystemTimeResponse);

  /// Get app state
  Future<void> shake() => _client.send(
      _handler.device.buildShakeDeviceRequest(),
      _handler.device.parseShakeDeviceResponse);

  /// For Android
  /// Press keycode
  Future<void> pressKeycode(int keycode,
          {List<int> metastate, List<int> flags}) =>
      _client.send(
          _handler.device.buildPressKeycodeRequest(keycode,
              metastate: metastate, flags: flags),
          _handler.device.parsePressKeycodeResponse);

  /// For Android
  /// Long press keycode
  Future<void> longPressKeycode(int keycode,
          {List<int> metastate, List<int> flags}) =>
      _client.send(
          _handler.device.buildLongPressKeycodeRequest(keycode,
              metastate: metastate, flags: flags),
          _handler.device.parseLongPressKeycodeResponse);

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
