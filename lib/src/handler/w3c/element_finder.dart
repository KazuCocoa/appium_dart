import 'package:appium_dart/src/common/by.dart';
import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart';
import 'package:webdriver/src/handler/w3c/utils.dart';

class W3cElementFinder extends ElementFinder {
  /// Here we massage [By] instances into viable W3C /element requests.
  ///
  /// In principle, W3C spec implementations should be nearly the same as
  /// the existing JSON wire spec. In practice compliance is uneven.
  Map<String, String> _byToJson(AppiumBy by) {
    return {'using': by.using, 'value': by.value};
  }

  @override
  WebDriverRequest buildFindElementsRequest(AppiumBy by, [String contextElementId]) {
    String uri = '${elementPrefix(contextElementId)}elements';
    return WebDriverRequest.postRequest(uri, _byToJson(by));
  }

  @override
  List<String> parseFindElementsResponse(WebDriverResponse response) {
    return (parseW3cResponse(response) as List)
        .map<String>((e) => e[w3cElementStr])
        .toList();
  }

  @override
  WebDriverRequest buildFindElementRequest(AppiumBy by, [String contextElementId]) {
    String uri = '${elementPrefix(contextElementId)}element';
    return WebDriverRequest.postRequest(uri, _byToJson(by));
  }

  @override
  String parseFindActiveElementResponse(WebDriverResponse response) {
    return parseW3cResponse(response)[w3cElementStr];
  }

  @override
  WebDriverRequest buildFindActiveElementRequest() {
    return WebDriverRequest.getRequest('element/active');
  }

  @override
  String parseFindElementResponse(WebDriverResponse response) {
    return parseW3cResponse(response)[w3cElementStr];
  }
}