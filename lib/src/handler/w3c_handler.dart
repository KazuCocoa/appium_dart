import 'dart:convert';

import 'package:appium_driver/src/handler/w3c/element_finder.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:appium_driver/src/handler/w3c/alert.dart';
import 'package:appium_driver/src/handler/w3c/app_state.dart';
import 'package:appium_driver/src/handler/w3c/cookies.dart';
import 'package:appium_driver/src/handler/w3c/core.dart';
import 'package:appium_driver/src/handler/w3c/element.dart';
import 'package:appium_driver/src/handler/w3c/frame.dart';
import 'package:appium_driver/src/handler/w3c/keyboard.dart';
import 'package:appium_driver/src/handler/w3c/mouse.dart';
import 'package:appium_driver/src/handler/w3c/navigation.dart';
import 'package:appium_driver/src/handler/w3c/session.dart';
import 'package:appium_driver/src/handler/w3c/timeouts.dart';
import 'package:appium_driver/src/handler/w3c/window.dart';
import 'package:appium_driver/src/handler/w3c/contexts.dart';
import 'package:appium_driver/src/handler/w3c/app_management.dart';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cWebDriverHandler extends AppiumWebDriverHandler {
  @override
  final SessionHandler session = W3cSessionHandler();

  @override
  final CoreHandler core = W3cCoreHandler();

  @override
  final KeyboardHandler keyboard = W3cKeyboardHandler();

  @override
  final MouseHandler mouse = W3cMouseHandler();

  @override
  final ElementFinder elementFinder = W3cElementFinder();

  @override
  final ElementHandler element = W3cElementHandler();

  @override
  final AlertHandler alert = W3cAlertHandler();

  @override
  final NavigationHandler navigation = W3cNavigationHandler();

  @override
  final WindowHandler window = W3cWindowHandler();

  @override
  final FrameHandler frame = W3cFrameHandler();

  @override
  final CookiesHandler cookies = W3cCookiesHandler();

  @override
  final TimeoutsHandler timeouts = W3cTimeoutsHandler();

  // Only for Appium
  @override
  final ContextsHandler contexts = W3cContextsHandler();

  // Only for Appium
  @override
  final AppManagementHandler app = W3cAppManagementHandler();

  // Only for Appium
  @override
  final AppStateHandler appState = W3cAppStateHandler();

  @override
  LogsHandler get logs =>
      throw UnsupportedError('Unsupported for W3cWebDriverHandler');

  @override
  WebDriverRequest buildGeneralRequest(HttpMethod method, String uri,
          [params]) =>
      WebDriverRequest(
          method, uri, params == null ? null : json.encode(serialize(params)));

  @override
  dynamic parseGeneralResponse(
          WebDriverResponse response, dynamic Function(String) createElement) =>
      deserialize(parseW3cResponse(response), createElement);

  @override
  String toString() => 'W3C';
}
