import 'dart:convert';

import 'package:appium_driver/src/handler/w3c/cdp.dart';
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
import 'package:appium_driver/src/handler/w3c/ime.dart';
import 'package:appium_driver/src/handler/w3c/device.dart';
import 'package:appium_driver/src/handler/w3c/settings.dart';
import 'package:appium_driver/src/handler/w3c/sessions.dart';
import 'package:appium_driver/src/handler/w3c/status.dart';
import 'package:appium_driver/src/handler/w3c/logs.dart';
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/handler/w3c/utils.dart'; // ignore: implementation_imports

class W3cWebDriverHandler extends AppiumWebDriverHandler {
  @override
  final SessionHandler session = W3cSessionHandler();

  @override
  final SessionsHandler sessions = W3cSessionsHandler();

  @override
  final StatusHandler status = W3cStatusHandler();

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

  // Only for Appium
  @override
  final IMEHandler ime = W3cIMEHandler();

  // Only for Appium
  @override
  final DeviceHandler device = W3cDeviceHandler();

  // Only for Appium
  @override
  final SettingsHandler settings = W3cSettingsHandler();

  @override
  final LogsHandler logs = W3cLogsHandler();

  @override
  final ChromeDevToolsHandler cdp = W3cChromeDevToolsHandler();

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
