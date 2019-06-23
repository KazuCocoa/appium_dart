import 'package:appium_driver/src/common/app_state.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cAppStateHandler implements AppStateHandler {
  @override
  WebDriverRequest buildGetAppStateRequest(String appId) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.APP_STATE, {'appId': appId});
  }

  @override
  AppState parseGetAppState(WebDriverResponse response) {
    return AppState.values[parseW3cResponse(response)];
  }
}
