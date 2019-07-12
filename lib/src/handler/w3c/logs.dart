import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';
import 'package:appium_driver/src/common/log.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cLogsHandler implements LogsHandler {
  @override
  WebDriverRequest buildGetAvailableTypeRequest() {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.GET_AVAILABLE_LOG_TYPES);
  }

  @override
  List<String> parseGetAvailableTypeResponse(WebDriverResponse response) {
    return parseW3cResponse(response).cast<String>();
  }

  @override
  WebDriverRequest buildGetLogsRequest(String logType) {
    return AppiumWebDriverRequest.sendRequest(
        W3CCommands.GET_LOG, {'type': logType});
  }

  @override
  List<AppiumLogEntry> parseGetLogsResponse(WebDriverResponse response) {
    List<dynamic> log = parseW3cResponse(response);
    return log.map((log) {
      return AppiumLogEntry.fromMap(log);
    }).toList();
  }
}
