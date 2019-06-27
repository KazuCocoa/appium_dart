import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cSettingsHandler implements SettingsHandler {
  @override
  WebDriverRequest buildGetSettingsRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.GET_SETTINGS);
  }

  @override
  dynamic parseGetSettingsResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildUpdateSettingsRequest(Map<String, dynamic> items) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.UPDATE_SETTINGS, {'settings': items});
  }

  @override
  void parseUpdateSettingsResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
