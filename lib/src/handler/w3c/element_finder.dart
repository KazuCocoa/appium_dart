import 'package:appium_driver/src/common/by.dart';
import 'package:appium_driver/src/common/search_context.dart' as search_context;
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cElementFinder extends ElementFinder {
  /// Here we massage [By] instances into viable W3C /element requests.
  ///
  /// In principle, W3C spec implementations should be nearly the same as
  /// the existing JSON wire spec. In practice compliance is uneven.
  Map<String, String> _byToJson(AppiumBy by) {
    return {'using': by.using, 'value': by.value};
  }

  @override
  WebDriverRequest buildFindElementsRequest(AppiumBy by,
      [String contextElementId]) {
    var uri = '${elementPrefix(contextElementId)}elements';
    return WebDriverRequest.postRequest(uri, _byToJson(by));
  }

  @override
  List<String> parseFindElementsResponse(WebDriverResponse response) {
    return (parseW3cResponse(response) as List)
        .map<String>((e) =>
            e[search_context.w3cElementStr] ??
            e[search_context.jsonWireElementStr])
        .toList();
  }

  @override
  WebDriverRequest buildFindElementRequest(AppiumBy by,
      [String contextElementId]) {
    var uri = '${elementPrefix(contextElementId)}element';
    return WebDriverRequest.postRequest(uri, _byToJson(by));
  }

  @override
  String parseFindActiveElementResponse(WebDriverResponse response) {
    var parsedResponse = parseW3cResponse(response);
    return parsedResponse[search_context.w3cElementStr] ??
        parsedResponse[search_context.jsonWireElementStr];
  }

  @override
  WebDriverRequest buildFindActiveElementRequest() {
    return WebDriverRequest.getRequest('element/active');
  }

  @override
  String parseFindElementResponse(WebDriverResponse response) {
    var parsedResponse = parseW3cResponse(response);
    return parsedResponse[search_context.w3cElementStr] ??
        parsedResponse[search_context.jsonWireElementStr];
  }
}
