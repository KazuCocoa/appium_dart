import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart';
import 'package:webdriver/src/handler/w3c/utils.dart';

class W3cTimeoutsHandler extends TimeoutsHandler {
  WebDriverRequest _buildSetTimeoutRequest(String type, Duration timeout) =>
      WebDriverRequest.postRequest('timeouts', {type: timeout.inMilliseconds});

  @override
  WebDriverRequest buildSetScriptTimeoutRequest(Duration timeout) =>
      _buildSetTimeoutRequest('script', timeout);

  @override
  void parseSetScriptTimeoutResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSetImplicitTimeoutRequest(Duration timeout) =>
      _buildSetTimeoutRequest('implicit', timeout);

  @override
  void parseSetImplicitTimeoutResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSetPageLoadTimeoutRequest(Duration timeout) =>
      _buildSetTimeoutRequest('pageLoad', timeout);

  @override
  void parseSetPageLoadTimeoutResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }
}
