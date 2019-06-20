import 'package:appium_driver/src/common/app_state.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cAppManagementHandler implements AppManagementHandler {
  @override
  WebDriverRequest buildActivateAppRequest(String appId) {
    return WebDriverRequest.postRequest(
        W3CCommands.ACTIVATE_APP.path, {'bundleId': appId});
  }

  @override
  void parseActivateAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildBackgroundAppRequest({Duration seconds}) {
    Map<String, dynamic> arg = {};
    if (seconds == null) {
      arg['seconds'] = Duration(seconds: 0).inMilliseconds;
    } else {
      arg['seconds'] = seconds.inMilliseconds;
    }

    return WebDriverRequest.postRequest(W3CCommands.BACKGROUND_APP.path, arg);
  }

  @override
  void parseBackgroundAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildCloseAppRequest() {
    return WebDriverRequest.postRequest(W3CCommands.CLOSE_APP.path);
  }

  @override
  void parseCloseAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetStringRequest() {
    return WebDriverRequest.postRequest(W3CCommands.APP_STRINGS.path);
  }

  @override
  Map<String, dynamic> parseGetStringResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildInstallAppRequest(String path,
      {replace, timeout, allowTestPackage, useSdcard, grantPermissions}) {
    Map<String, dynamic> arg = {'appPath': path, 'options': {}};
    if (replace != null) {
      arg['options']['replace'] = replace;
    }
    if (timeout != null) {
      arg['options']['timeout'] = timeout.inMilliseconds;
    }
    if (allowTestPackage != null) {
      arg['options']['allowTestPackages'] = allowTestPackage;
    }
    if (useSdcard != null) {
      arg['options']['useSdcard'] = useSdcard;
    }
    if (grantPermissions != null) {
      arg['options']['grantPermissions'] = grantPermissions;
    }
    return WebDriverRequest.postRequest(W3CCommands.INSTALL_APP.path, arg);
  }

  @override
  void parseInstallAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildIsAppInstalledRequest(String appId) {
    return WebDriverRequest.postRequest(
        W3CCommands.APP_INSTALLED.path, {'bundleId': appId});
  }

  @override
  bool parseIsAppInstalledResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildLaunchAppRequest() {
    return WebDriverRequest.postRequest(W3CCommands.LAUNCH_APP.path);
  }

  @override
  void parseLaunchAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildRemoveAppRequest(String appId, {keepData, timeout}) {
    Map<String, dynamic> arg = {'appId': appId, 'options': {}};
    if (keepData != null) {
      arg['options']['keepData'] = keepData;
    }
    if (timeout != null) {
      arg['options']['timeout'] = timeout.inMilliseconds;
    }
    return WebDriverRequest.postRequest(W3CCommands.REMOVE_APP.path, arg);
  }

  @override
  void parseRemoveAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildResetAppRequest() {
    return WebDriverRequest.postRequest(W3CCommands.RESET.path);
  }

  @override
  void parseResetAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildTerminateAppRequest(String appId) {
    return WebDriverRequest.postRequest(
        W3CCommands.TERMINATE_APP.path, {'bundleId': appId});
  }

  @override
  void parseTerminateResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
