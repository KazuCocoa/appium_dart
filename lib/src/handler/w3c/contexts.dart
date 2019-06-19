import 'package:appium_driver/src/common/webdriver_handler.dart'; // ignore: implementation_imports

import 'package:appium_driver/src/common/w3c/command.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cContextsHandler implements ContextsHandler {
  @override
  WebDriverRequest buildAvailableContextsRequest() {
    return WebDriverRequest.getRequest(
        W3CCommands.AVAILABLE_CONTEXTS.path);
  }

  @override
  List<String> parseAvailableContexts(WebDriverResponse response) {
    return parseW3cResponse(response).cast<String>();
  }
}
