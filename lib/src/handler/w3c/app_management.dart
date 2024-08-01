import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cAppManagementHandler implements AppManagementHandler {
  @override
  WebDriverRequest buildActivateAppRequest(String appId) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.ACTIVATE_APP, {'bundleId': appId});
  }

  @override
  void parseActivateAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildBackgroundAppRequest({Duration? seconds}) {
    var arg = <String, dynamic>{};
    if (seconds == null) {
      arg['seconds'] = const Duration(seconds: 0).inSeconds;
    } else {
      arg['seconds'] = seconds.inSeconds;
    }

    return AppiumWebDriverRequest.sendRequest(W3CCommands.BACKGROUND_APP, arg);
  }

  @override
  void parseBackgroundAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  void parseCloseAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetStringRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.APP_STRINGS);
  }

  @override
  Map<String, dynamic> parseGetStringResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildInstallAppRequest(String path,
      {replace, timeout, allowTestPackage, useSdcard, grantPermissions}) {
    var arg = <String, dynamic>{'appPath': path, 'options': {}};
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
    return AppiumWebDriverRequest.sendRequest(W3CCommands.INSTALL_APP, arg);
  }

  @override
  void parseInstallAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildIsAppInstalledRequest(String appId) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.APP_INSTALLED, {'bundleId': appId});
  }

  @override
  bool parseIsAppInstalledResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  void parseLaunchAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildRemoveAppRequest(String appId, {keepData, timeout}) {
    var arg = <String, dynamic>{'appId': appId, 'options': {}};
    if (keepData != null) {
      arg['options']['keepData'] = keepData;
    }
    if (timeout != null) {
      arg['options']['timeout'] = timeout.inMilliseconds;
    }
    return AppiumWebDriverRequest.sendRequest(W3CCommands.REMOVE_APP, arg);
  }

  @override
  void parseRemoveAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  void parseResetAppResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildTerminateAppRequest(String appId) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.TERMINATE_APP, {'bundleId': appId});
  }

  @override
  void parseTerminateResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
