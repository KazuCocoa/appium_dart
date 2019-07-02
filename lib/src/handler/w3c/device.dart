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
}
