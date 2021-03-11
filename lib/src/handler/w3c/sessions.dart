import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cSessionsHandler implements SessionsHandler {
  @override
  WebDriverRequest buildGetRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.GET_ALL_SESSIONS);
  }

  @override
  List<dynamic>? parseGetResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }
}
