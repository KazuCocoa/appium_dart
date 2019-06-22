import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cIMEHandler implements IMEHandler {
  @override
  WebDriverRequest buildGetAvailableEnginesRequest() {
    return WebDriverRequest.getRequest(
        W3CCommands.IME_GET_AVAILABLE_ENGINES.path);
  }

  @override
  List<String> parseGetAvailableEngines(WebDriverResponse response) {
    return parseW3cResponse(response).cast<String>();
  }

  @override
  WebDriverRequest buildGetActiveEngineRequest() {
    return WebDriverRequest.getRequest(W3CCommands.IME_GET_ACTIVE_ENGINE.path);
  }

  @override
  String parseGetActiveEngine(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildIsActivatedRequest() {
    return WebDriverRequest.getRequest(W3CCommands.IME_IS_ACTIVATED.path);
  }

  @override
  bool parseIsActivated(WebDriverResponse response) {
    return parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDeactivateRequest() {
    return WebDriverRequest.postRequest(W3CCommands.IME_DEACTIVATE.path);
  }

  @override
  void parseDeactivate(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildActiveEngineRequest(String imeName) {
    return WebDriverRequest.postRequest(
        W3CCommands.IME_ACTIVATE_ENGINE.path, {'engine': imeName});
  }

  @override
  void parseActiveEngine(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
