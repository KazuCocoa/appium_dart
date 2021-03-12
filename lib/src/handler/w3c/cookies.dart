import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/cookie.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cCookiesHandler extends CookiesHandler {
  @override
  WebDriverRequest buildAddCookieRequest(Cookie cookie) =>
      WebDriverRequest.postRequest('cookie', {'cookie': _serialize(cookie)});

  @override
  void parseAddCookieResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDeleteCookieRequest(String name) =>
      WebDriverRequest.deleteRequest('cookie/$name');

  @override
  void parseDeleteCookieResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildDeleteAllCookiesRequest() =>
      WebDriverRequest.deleteRequest('cookie');

  @override
  void parseDeleteAllCookiesResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildGetCookieRequest(String name) =>
      WebDriverRequest.getRequest('cookie/$name');

  @override
  Cookie parseGetCookieResponse(WebDriverResponse response, String name) =>
      _deserialize(parseW3cResponse(response));

  @override
  WebDriverRequest buildGetAllCookiesRequest() =>
      WebDriverRequest.getRequest('cookie');

  @override
  List<Cookie> parseGetAllCookiesResponse(WebDriverResponse response) =>
      parseW3cResponse(response).map<Cookie>(_deserialize).toList();

  /// Serialises the cookie to json object according to the spec.
  ///
  /// The spec is serialising a cookie the same we do in [Cookie.toJson].
  Map<String, dynamic> _serialize(Cookie cookie) => cookie.toJson();

  /// Deserializes the json object to get the cookie according to the spec.
  ///
  /// The spec is deserializing the same we do in [Cookie.fromJson].
  Cookie _deserialize(dynamic content) => Cookie.fromJson(content);
}
