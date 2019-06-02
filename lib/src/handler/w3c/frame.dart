import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cFrameHandler extends FrameHandler {
  @override
  WebDriverRequest buildSwitchByIdRequest([int id]) =>
      WebDriverRequest.postRequest('frame', {'id': id});

  @override
  void parseSwitchByIdResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSwitchByElementRequest(String elementId) =>
      WebDriverRequest.postRequest('frame', {
        'id': {w3cElementStr: elementId}
      });

  @override
  void parseSwitchByElementResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSwitchToParentRequest() =>
      WebDriverRequest.postRequest('frame/parent');

  @override
  void parseSwitchToParentResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
