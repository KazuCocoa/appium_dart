import 'package:appium_driver/src/common/request.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cExecuteDriverHandler implements ExecuteDriverHandler {
  @override
  WebDriverRequest buildExecuteDriverRequest(String script, String type, Duration timeoutMs) {
    // TODO: Make timeoutMs nullable
    return AppiumWebDriverRequest.sendRequest(
      W3CCommands.EXECUTE_DRIVER, {'script': script, 'type': type, 'timeout': timeoutMs.inMilliseconds}
    );
  }

  @override
  Map<String, dynamic> parseExecuteDriverResponse(WebDriverResponse response) =>
    parseW3cResponse(response);
}
