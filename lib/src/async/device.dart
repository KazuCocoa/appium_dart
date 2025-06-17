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

  /// Get the device lock status.
  ///
  /// Returns true if the device under test was locked.
  ///
  /// For example:
  ///
  ///     await driver.device.isLocked();
  ///
  Future<bool> isLocked() => _client.send(
      _handler.device.buildDeviceIsLockedRequest(),
      _handler.device.parseDeviceIsLockedResponse);

  /// Lock the device under test.
  ///
  /// For example:
  ///
  ///     await driver.device.lock(seconds: const Duration(seconds: 2));
  ///
  Future<void> lock({Duration? seconds}) => _client.send(
      _handler.device.buildLockDeviceRequest(seconds: seconds),
      _handler.device.parseLockDeviceResponse);

  /// Unlock the device under test
  ///
  /// For example:
  ///
  ///     await driver.device.unlock();
  ///
  Future<void> unlock() => _client.send(
      _handler.device.buildUnlockDeviceRequest(),
      _handler.device.parseUnlockDeviceResponse);

  /// Get the time of the device under test.
  ///
  /// Returns current device time as string
  ///
  /// For example:
  ///
  ///     var time = await driver.device.getSystemTime();
  ///     expect(DateTime.parse(time) is DateTime, true);
  ///
  Future<String> getSystemTime() => _client.send(
      _handler.device.buildDeviceSystemTimeRequest(),
      _handler.device.parseDeviceSystemTimeResponse);

  /// Shake the device under test
  ///
  /// For example:
  ///
  ///     await driver.device.shake();
  ///
  Future<void> shake() => _client.send(
      _handler.device.buildShakeDeviceRequest(),
      _handler.device.parseShakeDeviceResponse);

  /// For Android
  /// Press keycode
  ///
  /// For example:
  ///
  ///     await driver.device.pressKeycode(66, metastate: [1], flags: [32]);
  ///
  Future<void> pressKeycode(int keycode,
          {List<int>? metastate, List<int>? flags}) =>
      _client.send(
          _handler.device.buildPressKeycodeRequest(keycode,
              metastate: metastate, flags: flags),
          _handler.device.parsePressKeycodeResponse);

  /// For Android
  /// Long press keycode
  ///
  /// For example:
  ///
  ///     await driver.device.longPressKeycode(66, metastate: [1], flags: [32]);
  ///
  Future<void> longPressKeycode(int keycode,
          {List<int>? metastate, List<int>? flags}) =>
      _client.send(
          _handler.device.buildLongPressKeycodeRequest(keycode,
              metastate: metastate, flags: flags),
          _handler.device.parseLongPressKeycodeResponse);

  /// Push the base 64 encoded file to the device under test
  ///
  /// For example:
  ///
  ///     await driver.device.pushFile('asPng.png', base64EncodedPngFile);
  ///
  Future<void> pushFile(String path, String base64EncodedData) => _client.send(
      _handler.device.buildPushFileRequest(path, base64EncodedData),
      _handler.device.parseLPushFileResponse);

  /// Pull a file as base 64 encoded string
  ///
  /// For example:
  ///
  ///     var pulledFile = await driver.device
  ///         .pullFile('Library/AddressBook/AddressBook.sqlitedb');
  ///     expect(pulledFile.isNotEmpty, true);
  ///
  Future<String> pullFile(String path) => _client.send(
      _handler.device.buildPullFileRequest(path),
      _handler.device.parsePullFileResponse);

  /// Pull a folder as base 64 encoded string
  ///
  /// For example:
  ///
  ///     var pulFolder = await driver.device.pullFolder('Library/AddressBook');
  ///     expect(pulFolder.isNotEmpty, true);
  ///
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
          {String contentType = ContentType.plaintext, String? label}) =>
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
          {String? appPackage,
          String? appActivity,
          String? appWaitPackage,
          String? appWaitActivity,
          String? intentAction,
          String? intentCategory,
          String? intentFlags,
          String? optionalIntentArguments,
          String? dontStopAppOnReset}) =>
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

  /// Get current package.
  /// Only for Android.
  ///
  /// For example:
  ///
  ///     await driver.device.getCurrentPackage()
  ///
  Future<String> getCurrentPackage() => _client.send(
      _handler.device.buildGetCurrentPackageRequest(),
      _handler.device.parseGetCurrentPackageResponse);

  /// Set location.
  ///
  /// For example:
  ///
  ///     await driver.device.setLocation(Location(100.0, 30.0, 0.0));
  ///
  Future<void> setLocation(Location location) => _client.send(
      _handler.device.buildSetLocationRequest(location),
      _handler.device.parseSetLocationResponse);

  /// Get current location.
  ///
  /// Returns Location.
  ///
  /// For example:
  ///
  ///     Location l = await driver.device.getLocation();
  ///     expect(l.longitude != null, true);
  ///     expect(l.longitude != null, true);
  ///     expect(l.longitude != null, true);
  ///
  Future<Location> getLocation() => _client.send(
      _handler.device.buildGetLocationRequest(),
      _handler.device.parseGetLocationResponse);

  /// Get the system bar.
  /// For Android
  ///
  /// Example:
  ///
  ///     var systemBar = await driver.device.getSystemBars();
  ///     expect(systemBar['statusBar'] != null, true);
  ///     expect(systemBar['navigationBar'] != null, true);
  ///
  Future<Map<String, dynamic>> getSystemBars() => _client.send(
      _handler.device.buildGetSystemBarsRequest(),
      _handler.device.parseGetSystemBarsResponse);

  /// Get the display density.
  /// For Android
  ///
  /// Example:
  ///
  ///     await driver.device.getDisplayDensity();
  ///
  Future<int> getDisplayDensity() => _client.send(
      _handler.device.buildGetDisplayDensityRequest(),
      _handler.device.parseGetDisplayDensityResponse);

  /// Set the device orientation.
  ///
  /// Example:
  ///
  ///     await driver.device.setOrientation(Orientation.LANDSCAPE);
  ///
  Future<void> setOrientation(Orientation orientation) => _client.send(
      _handler.device.buildSetOrientationRequest(orientation),
      _handler.device.parseSetOrientationResponse);

  /// Get the device orientation.
  ///
  /// Returns Orientation.
  ///
  /// Example:
  ///
  ///     await driver.device.getOrientation();
  ///
  Future<Orientation> getOrientation() => _client.send(
      _handler.device.buildGetOrientationRequest(),
      _handler.device.parseGetOrientationResponse);

  /// Toggle airplane mode (Android only)
  Future<void> toggleAirplaneMode() => _client.send(
      _handler.device.buildToggleAirplaneModeRequest(),
      _handler.device.parseToggleAirplaneModeResponse);

  /// Toggle WiFi (Android only)
  Future<void> toggleWiFi() => _client.send(
      _handler.device.buildToggleWiFiRequest(),
      _handler.device.parseToggleWiFiResponse);

  /// Toggle mobile data (Android only)
  Future<void> toggleData() => _client.send(
      _handler.device.buildToggleDataRequest(),
      _handler.device.parseToggleDataResponse);

  /// Toggle location services (Android only)
  Future<void> toggleLocationServices() => _client.send(
      _handler.device.buildToggleLocationServicesRequest(),
      _handler.device.parseToggleLocationServicesResponse);

  /// End test coverage (Android only)
  Future<void> endTestCoverage(String intent, String path) => _client.send(
      _handler.device.buildEndTestCoverageRequest(intent, path),
      _handler.device.parseEndTestCoverageResponse);

  /// Get performance data types (Android only)
  Future<List<String>> getPerformanceDataTypes() => _client.send(
      _handler.device.buildGetPerformanceDataTypesRequest(),
      _handler.device.parseGetPerformanceDataTypesResponse);

  /// Get performance data (Android only)
  Future<List<List<String>>> getPerformanceData(
          String packageName, String dataType,
          {int? dataReadTimeout}) =>
      _client.send(
          _handler.device.buildGetPerformanceDataRequest(
              packageName, dataType, dataReadTimeout),
          _handler.device.parseGetPerformanceDataResponse);

  /// Send SMS (Android only)
  Future<void> sendSms(String phoneNumber, String message) => _client.send(
      _handler.device.buildSendSmsRequest(phoneNumber, message),
      _handler.device.parseSendSmsResponse);

  /// GSM call (Android only)
  Future<void> gsmCall(String phoneNumber, String action) => _client.send(
      _handler.device.buildGsmCallRequest(phoneNumber, action),
      _handler.device.parseGsmCallResponse);

  /// GSM signal (Android only)
  Future<void> gsmSignal(int strength) => _client.send(
      _handler.device.buildGsmSignalRequest(strength),
      _handler.device.parseGsmSignalResponse);

  /// GSM voice (Android only)
  Future<void> gsmVoice(String state) => _client.send(
      _handler.device.buildGsmVoiceRequest(state),
      _handler.device.parseGsmVoiceResponse);

  /// Set network speed (Android only)
  Future<void> setNetworkSpeed(String speed) => _client.send(
      _handler.device.buildSetNetworkSpeedRequest(speed),
      _handler.device.parseSetNetworkSpeedResponse);

  /// Set power capacity (Android only)
  Future<void> setPowerCapacity(int percent) => _client.send(
      _handler.device.buildSetPowerCapacityRequest(percent),
      _handler.device.parseSetPowerCapacityResponse);

  /// Set power AC state (Android only)
  Future<void> setPowerAc(String state) => _client.send(
      _handler.device.buildSetPowerAcRequest(state),
      _handler.device.parseSetPowerAcResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Device && other._client == _client && other._handler == _handler;

  @override
  String toString() => '$_handler.appState($_client)';
}
