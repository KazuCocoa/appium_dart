import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cChromeDevToolsHandler implements ChromeDevToolsHandler {
  @override
  WebDriverRequest buildExecuteRequest(
          String command, Map<String, dynamic> params) =>
      AppiumWebDriverRequest.sendRequest(
          W3CCommands.EXECUTE_CDP, {'cmd': command, 'params': params});

  @override
  Map<String, dynamic>? parseExecuteResponse(WebDriverResponse response) =>
      parseW3cResponse(response);
}
