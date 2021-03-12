import 'package:appium_driver/src/common/webdriver_handler.dart'; // ignore: implementation_imports

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cContextsHandler implements ContextsHandler {
  @override
  WebDriverRequest buildGetAvailableContextsRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.AVAILABLE_CONTEXTS);
  }

  @override
  List<String> parseGetAvailableContexts(WebDriverResponse response) {
    return parseW3cResponse(response).cast<String>();
  }

  @override
  WebDriverRequest buildGetCurrentContextRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.CURRENT_CONTEXT);
  }

  @override
  WebDriverRequest buildSetContextRequest(String context) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.SET_CONTEXT, {'name': context});
  }

  @override
  String parseGetCurrentContext(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  void parseSetContextResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
