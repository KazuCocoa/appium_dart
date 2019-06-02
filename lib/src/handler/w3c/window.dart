import 'dart:math';

import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request.dart';  // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart';  // ignore: implementation_imports

class W3cWindowHandler extends WindowHandler {
  @override
  WebDriverRequest buildGetWindowsRequest() =>
      WebDriverRequest.getRequest('window/handles');

  @override
  List<String> parseGetWindowsResponse(WebDriverResponse response) =>
      parseW3cResponse(response).cast<String>();

  @override
  WebDriverRequest buildGetActiveWindowRequest() =>
      WebDriverRequest.getRequest('window');

  @override
  String parseGetActiveWindowResponse(WebDriverResponse response) =>
      parseW3cResponse(response);

  @override
  WebDriverRequest buildSetActiveRequest(String windowId) =>
      WebDriverRequest.postRequest('window', {'handle': windowId});

  @override
  void parseSetActiveResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildLocationRequest() => buildRectRequest();

  @override
  Point<int> parseLocationResponse(WebDriverResponse response) =>
      parseRectResponse(response).topLeft;

  @override
  WebDriverRequest buildSizeRequest() => buildRectRequest();

  @override
  Rectangle<int> parseSizeResponse(WebDriverResponse response) {
    final rect = parseRectResponse(response);
    return Rectangle(0, 0, rect.width, rect.height);
  }

  @override
  WebDriverRequest buildRectRequest() =>
      WebDriverRequest.getRequest('window/rect');

  @override
  Rectangle<int> parseRectResponse(WebDriverResponse response) {
    final rect = parseW3cResponse(response);
    return Rectangle(rect['x'].toInt(), rect['y'].toInt(),
        rect['width'].toInt(), rect['height'].toInt());
  }

  @override
  WebDriverRequest buildSetLocationRequest(Point<int> location) =>
      WebDriverRequest.postRequest(
          'window/rect', {'x': location.x, 'y': location.y});

  @override
  void parseSetLocationResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSetSizeRequest(Rectangle<int> size) =>
      WebDriverRequest.postRequest(
          'window/rect', {'width': size.width, 'height': size.height});

  @override
  void parseSetSizeResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSetRectRequest(Rectangle<int> rect) =>
      WebDriverRequest.postRequest('window/rect', {
        'x': rect.left,
        'y': rect.top,
        'width': rect.width,
        'height': rect.height
      });

  @override
  void parseSetRectResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildMaximizeRequest() =>
      WebDriverRequest.postRequest('window/maximize');

  @override
  void parseMaximizeResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildMinimizeRequest() =>
      WebDriverRequest.postRequest('window/minimize');

  @override
  void parseMinimizeResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildCloseRequest() =>
      WebDriverRequest.deleteRequest('window');

  @override
  void parseCloseResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildInnerSizeRequest() =>
      WebDriverRequest.postRequest('execute/sync', {
        'script':
            'return { width: window.innerWidth, height: window.innerHeight };',
        'args': []
      });

  @override
  Rectangle<int> parseInnerSizeResponse(WebDriverResponse response) {
    final size = parseW3cResponse(response);
    return Rectangle(0, 0, size['width'], size['height']);
  }
}
