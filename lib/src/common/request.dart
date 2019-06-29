import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:appium_driver/src/common/w3c/command.dart';

/// Wrap WebDriverRequest
class AppiumWebDriverRequest {
  static WebDriverRequest sendRequest(Command command, [params]) {
    switch (command.method) {
      case HttpMethod.httpGet:
        return WebDriverRequest.getRequest(command.path);
      case HttpMethod.httpPost:
        return WebDriverRequest.postRequest(command.path, params);
      case HttpMethod.httpDelete:
        return WebDriverRequest.deleteRequest(command.path);
    }
    throw UnimplementedError;
  }

  static WebDriverRequest sendElementRequest(Command command, String elementId,
      [params]) {
    var path = command.path.replaceFirst('element/:id', 'element/$elementId');

    switch (command.method) {
      case HttpMethod.httpGet:
        return WebDriverRequest.getRequest(path);
      case HttpMethod.httpPost:
        return WebDriverRequest.postRequest(path, params);
      case HttpMethod.httpDelete:
        return WebDriverRequest.deleteRequest(path);
    }
    throw UnimplementedError;
  }
}
