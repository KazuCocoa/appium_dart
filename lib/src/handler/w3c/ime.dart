import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cIMEHandler implements IMEHandler {
  @override
  WebDriverRequest buildGetAvailableEnginesRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IME_GET_AVAILABLE_ENGINES);
  }

  @override
  List<String> parseGetAvailableEngines(WebDriverResponse response) {
    return parseW3cResponse(response).cast<String>();
  }

  @override
  WebDriverRequest buildGetActiveEngineRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IME_GET_ACTIVE_ENGINE);
  }

  @override
  String parseGetActiveEngine(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildIsActivatedRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IME_IS_ACTIVATED);
  }

  @override
  bool parseIsActivated(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDeactivateRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IME_DEACTIVATE);
  }

  @override
  void parseDeactivate(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildActiveEngineRequest(String imeName) {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IME_ACTIVATE_ENGINE, {'engine': imeName});
  }

  @override
  void parseActiveEngine(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
