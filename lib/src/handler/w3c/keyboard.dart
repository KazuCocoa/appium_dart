import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:appium_driver/src/common/w3c/command.dart';
import 'package:appium_driver/src/common/request.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cKeyboardHandler extends KeyboardHandler {
  @override
  WebDriverRequest buildSendChordRequest(Iterable<String> chordToSend) {
    final keyDownActions = <Map<String, String>>[];
    final keyUpActions = <Map<String, String>>[];
    for (String s in chordToSend) {
      keyDownActions.add({'type': 'keyDown', 'value': s});
      keyUpActions.add({'type': 'keyUp', 'value': s});
    }

    return WebDriverRequest.postRequest('actions', {
      'actions': [
        {
          'type': 'key',
          'id': 'keys',
          'actions':
              keyDownActions + keyUpActions.reversed.toList(growable: false)
        }
      ]
    });
  }

  @override
  void parseSendChordResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildSendKeysRequest(String keysToSend) {
    final keyActions = <Map<String, String>>[];
    for (int i = 0; i < keysToSend.length; ++i) {
      keyActions.add({'type': 'keyDown', 'value': keysToSend[i]});
      keyActions.add({'type': 'keyUp', 'value': keysToSend[i]});
    }
    return WebDriverRequest.postRequest('actions', {
      'actions': [
        {'type': 'key', 'id': 'keys', 'actions': keyActions}
      ]
    });
  }

  @override
  void parseSendKeysResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildHideKeyboardRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.HIDE_KEYBOARD);
  }

  @override
  void parseHideKeyboardResponse(WebDriverResponse response) {
    parseW3cResponse(response);
  }

  @override
  WebDriverRequest buildIsKeyboardShownRequest() {
    return AppiumWebDriverRequest.sendRequest(W3CCommands.IS_KEYBOARD_SHOWN);
  }

  @override
  bool parseIsKeyboardShownResponse(WebDriverResponse response) {
    return parseW3cResponse(response);
  }


}
