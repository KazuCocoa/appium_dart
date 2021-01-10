import 'dart:async';

import 'package:appium_driver/src/common/clipboard.dart';
import 'package:appium_driver/src/common/orientation.dart';
import 'package:appium_driver/src/common/utils.dart';
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

  Future<void> pushFile(String path, String base64EncodedData) => _client.send(
      _handler.device.buildPushFileRequest(path, base64EncodedData),
      _handler.device.parseLPushFileResponse);

  Future<String> pullFile(String path) => _client.send(
      _handler.device.buildPullFileRequest(path),
      _handler.device.parsePullFileResponse);

  Future<String> pullFolder(String path) => _client.send(
      _handler.device.buildPullFolderRequest(path),
      _handler.device.parsePullFolderResponse);

  /// Get clipboard
  ///
  /// Returns base64 encoded string. You must decode it properly.
  ///
  /// For example:
  ///
  ///     // Returns a string which is base64 encoded
  ///     utf8.decode(base64.decode(await driver.device.getClipboard()))
  ///
  Future<String> getClipboard({String contentType = ContentType.plaintext}) =>
      _client.send(
          _handler.device.buildGetClipboardRequest(contentType: contentType),
          _handler.device.parseGetClipboardResponse);

  /// Set clipboard
  /// Sends base64 encoded string. You must decode it properly as the 1st argument.
  ///
  /// `label` argument is only for Android like `'Note'`
  ///
  /// For example:
  ///
  ///     // Gives base64 encoded string
  ///     await driver.device.setClipboard(
  ///         base64.encode(utf8.encode('happy testing')));
  ///
  Future<void> setClipboard(String base64encoded,
          {String contentType = ContentType.plaintext, String label}) =>
      _client.send(
          _handler.device.buildSetClipboardRequest(base64encoded,
              contentType: contentType, label: label),
          _handler.device.parseSetClipboardResponse);

  /// Open notification
  /// Only for Android.
  ///
  /// For example:
  ///
  ///     await driver.device.openNotification()
  ///
  Future<void> openNotification() => _client.send(
      _handler.device.buildOpenNotificationRequest(),
      _handler.device.parseOpenNotificationResponse);

  /// Start Activity
  /// Only for Android.
  ///
  /// For example:
  ///
  ///     await driver.device.startActivity(
  ///       appPackage: 'io.appium.android.apis',
  ///       appActivity: 'io.appium.android.apis.ApiDemos');
  ///
  Future<void> startActivity(
          {String appPackage,
          String appActivity,
          String appWaitPackage,
          String appWaitActivity,
          String intentAction,
          String intentCategory,
          String intentFlags,
          String optionalIntentArguments,
          String dontStopAppOnReset}) =>
      _client.send(
          _handler.device.buildStartActivityRequest(
              appPackage: appPackage,
              appActivity: appActivity,
              appWaitPackage: appWaitPackage,
              appWaitActivity: appWaitActivity,
              intentAction: intentAction,
              intentCategory: intentCategory,
              intentFlags: intentFlags,
              optionalIntentArguments: optionalIntentArguments,
              dontStopAppOnReset: dontStopAppOnReset),
          _handler.device.parseStartActivityResponse);

  /// Get current activity
  /// Only for Android.
  ///
  /// For example:
  ///
  ///     await driver.device.getCurrentActivity()
  ///
  Future<String> getCurrentActivity() => _client.send(
      _handler.device.buildGetCurrentActivityRequest(),
      _handler.device.parseGetCurrentActivityResponse);

  /// Get current package
  /// Only for Android.
  ///
  /// For example:
  ///
  ///     await driver.device.getCurrentPackage()
  ///
  Future<String> getCurrentPackage() => _client.send(
      _handler.device.buildGetCurrentPackageRequest(),
      _handler.device.parseGetCurrentPackageResponse);

  /// Set  location
  Future<void> setLocation(Location location) => _client.send(
      _handler.device.buildSetLocationRequest(location),
      _handler.device.parseSetLocationResponse);

  /// Get current location
  Future<Location> getLocation() => _client.send(
      _handler.device.buildGetLocationRequest(),
      _handler.device.parseGetLocationResponse);

  /// Get display density.
  /// For Android
  Future<Map<String, dynamic>> getSystemBars() => _client.send(
      _handler.device.buildGetSystemBarsRequest(),
      _handler.device.parseGetSystemBarsResponse);

  /// Get display density.
  /// For Android
  Future<int> getDisplayDensity() => _client.send(
      _handler.device.buildGetDisplayDensityRequest(),
      _handler.device.parseGetDisplayDensityResponse);

  /// Set orientation
  Future<void> setOrientation(Orientation orientation) => _client.send(
      _handler.device.buildSetOrientationRequest(orientation),
      _handler.device.parseSetOrientationResponse);

  /// Get orientation
  Future<Orientation> getOrientation() => _client.send(
      _handler.device.buildGetOrientationRequest(),
      _handler.device.parseGetOrientationResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Device && other._client == _client && other._handler == _handler;

  @override
  String toString() => '$_handler.appState($_client)';
}
