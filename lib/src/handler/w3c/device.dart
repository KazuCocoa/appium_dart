import 'package:appium_driver/src/common/clipboard.dart';
import 'package:appium_driver/src/common/utils.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cDeviceHandler implements DeviceHandler {
  @override
  WebDriverRequest buildDeviceIsLockedRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.DEVICE_LOCKED);
  }

  @override
  bool parseDeviceIsLockedResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildLockDeviceRequest({Duration seconds}) {
    Map<String, dynamic> arg = {};
    if (seconds == null) {
      arg['seconds'] = Duration(seconds: 0).inSeconds;
    } else {
      arg['seconds'] = seconds.inSeconds;
    }

    return AppiumWebDriverRequest.sendRequest(W3CCommands.LOCK, arg);
  }

  @override
  void parseLockDeviceResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildUnlockDeviceRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.UNLOCK);
  }

  @override
  void parseUnlockDeviceResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDeviceSystemTimeRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.DEVICE_TIME);
  }

  @override
  String parseDeviceSystemTimeResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildShakeDeviceRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.SHAKE);
  }

  @override
  void parseShakeDeviceResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildPressKeycodeRequest(int keycode,
      {List<int> metastate, List<int> flags}) {
    Map<String, dynamic> arg = {'keycode': keycode};
    if (metastate != null) {
      arg['metastate'] = metastate;
    }
    if (flags != null) {
      arg['flags'] = flags;
    }
    return AppiumWebDriverRequest.sendRequest(W3CCommands.PRESS_KEYCODE, arg);
  }

  @override
  void parsePressKeycodeResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildLongPressKeycodeRequest(int keycode,
      {List<int> metastate, List<int> flags}) {
    Map<String, dynamic> arg = {'keycode': keycode};
    if (metastate != null) {
      arg['metastate'] = metastate;
    }
    if (flags != null) {
      arg['flags'] = flags;
    }
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.LONG_PRESS_KEYCODE, arg);
  }

  @override
  void parseLongPressKeycodeResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildPushFileRequest(String path, String base64EncodedData) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.PUSH_FILE, {'path': path, 'data': base64EncodedData});
  }

  @override
  void parseLPushFileResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildPullFileRequest(String path) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.PULL_FILE, {'path': path});
  }

  @override
  String parsePullFileResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildPullFolderRequest(String path) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.PULL_FOLDER, {'path': path});
  }

  @override
  String parsePullFolderResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetClipboardRequest(
      {String contentType = ContentType.plaintext}) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.GET_CLIPBOARD, {'contentType': contentType});
  }

  @override
  String parseGetClipboardResponse(WebDriverResponse response) {
    // return base64 encoded data
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSetClipboardRequest(String base64encoded,
      {String contentType = ContentType.plaintext, String label}) {
    var arg = {'content': base64encoded, 'contentType': contentType};
    if (label != null) {
      arg['label'] = label;
    }
    return AppiumWebDriverRequest.sendRequest(W3CCommands.SET_CLIPBOARD, arg);
  }

  @override
  void parseSetClipboardResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildOpenNotificationRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.OPEN_NOTIFICATIONS);
  }

  @override
  void parseOpenNotificationResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildStartActivityRequest(
      {String appPackage,
      String appActivity,
      String appWaitPackage,
      String appWaitActivity,
      String intentAction,
      String intentCategory,
      String intentFlags,
      String optionalIntentArguments,
      String dontStopAppOnReset}) {
    var arg = {'appPackage': appPackage, 'appActivity': appActivity};
    if (appWaitPackage != null) {
      arg['appWaitPackage'] = appWaitPackage;
    }
    if (appWaitActivity != null) {
      arg['appWaitActivity'] = appWaitActivity;
    }

    if (intentAction != null) {
      arg['intentAction'] = intentAction;
    }
    if (intentCategory != null) {
      arg['intentCategory'] = intentCategory;
    }
    if (appWaitPackage != null) {
      arg['intentFlags'] = intentFlags;
    }
    if (optionalIntentArguments != null) {
      arg['optionalIntentArguments'] = optionalIntentArguments;
    }
    if (dontStopAppOnReset != null) {
      arg['dontStopAppOnReset'] = dontStopAppOnReset;
    }
    return AppiumWebDriverRequest.sendRequest(W3CCommands.START_ACTIVITY, arg);
  }

  @override
  void parseStartActivityResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetCurrentActivityRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.CURRENT_ACTIVITY);
  }

  @override
  String parseGetCurrentActivityResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetCurrentPackageRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.CURRENT_PACKAGE);
  }

  @override
  String parseGetCurrentPackageResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetLocationRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.GET_LOCATION);
  }

  @override
  Location parseGetLocationResponse(WebDriverResponse response) {
    var r = parseW3cResponse(response);
    return Location(r['latitude'], r['longitude'], r['altitude']);
  }

  @override
  WebDriverRequest buildSetLocationRequest(Location location) {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.SET_LOCATION, {
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'altitude': location.altitude
      }
    });
  }

  @override
  void parseSetLocationResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetSystemBarsRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.GET_SYSTEM_BARS);
  }

  @override
  Map<String, dynamic> parseGetSystemBarsResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetDisplayDensityRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.GET_DISPLAY_DENSITY);
  }

  @override
  int parseGetDisplayDensityResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }
}
