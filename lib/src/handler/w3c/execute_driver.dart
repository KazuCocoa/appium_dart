import 'package:appium_driver/src/common/request.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cExecuteDriverHandler implements ExecuteDriverHandler {
  @override
  WebDriverRequest buildExecuteDriverRequest(String script,
      {String? type, Duration? timeout}) {
    Map<String, dynamic> arg = {'script': script};
    if (type != null) {
      // arg['type'] = type;
    } else {
      arg['type'] = 'webdriverio';
    }
    if (timeout != null) {
      arg['timeout'] = timeout.inMilliseconds;
    }
    return AppiumWebDriverRequest.sendRequest(W3CCommands.EXECUTE_DRIVER, arg);
  }

  @override
  Map<String, dynamic>? parseExecuteDriverResponse(WebDriverResponse response) =>
      parseW3cResponse(response);
}
