import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cAlertHandler implements AlertHandler {
  @override
  WebDriverRequest buildGetTextRequest() =>
      WebDriverRequest.getRequest('alert/text');

  @override
  String parseGetTextResponse(WebDriverResponse response) =>
      parseW3cResponse(response);

  @override
  WebDriverRequest buildAcceptRequest() =>
      WebDriverRequest.postRequest('alert/accept');

  @override
  void parseAcceptResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDismissRequest() =>
      WebDriverRequest.postRequest('alert/dismiss');

  @override
  void parseDismissResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  // This does NOT match the W3C spec, which specifies 'value' not 'text'.
  // But this is what geckodriver uses.
  @override
  WebDriverRequest buildSendTextRequest(String keysToSend) =>
      WebDriverRequest.postRequest('alert/text', {'text': keysToSend});

  @override
  void parseSendTextResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
