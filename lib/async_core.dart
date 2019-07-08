library appium_driver.core;

import 'dart:async' show Future;
import 'dart:collection' show UnmodifiableMapView;

import 'package:appium_driver/src/common/utils.dart';
import 'package:appium_driver/src/async/web_driver.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/spec.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/capabilities.dart'; // ignore: implementation_imports

export 'package:appium_driver/async_core.dart';
export 'package:appium_driver/src/common/by.dart';
export 'package:appium_driver/src/common/app_state.dart';
export 'package:appium_driver/src/common/utils.dart' hide getHandler;
export 'package:appium_driver/src/async/web_driver.dart';
export 'package:appium_driver/src/async/web_element.dart';
export 'package:appium_driver/src/async/target_locator.dart';
export 'package:appium_driver/src/async/alert.dart';
export 'package:appium_driver/src/async/cookies.dart';
export 'package:appium_driver/src/async/keyboard.dart';
export 'package:appium_driver/src/async/logs.dart';
export 'package:appium_driver/src/async/mouse.dart';
export 'package:appium_driver/src/async/timeouts.dart';
export 'package:appium_driver/src/async/window.dart';
export 'package:appium_driver/src/async/contexts.dart';
export 'package:appium_driver/src/async/ime.dart';
export 'package:appium_driver/src/async/device.dart';
export 'package:appium_driver/src/async/settings.dart';
export 'package:appium_driver/src/async/sessions.dart';
export 'package:appium_driver/src/async/status.dart';

export 'package:webdriver/src/common/command_event.dart';
export 'package:webdriver/src/common/cookie.dart';
export 'package:webdriver/src/common/exception.dart';
export 'package:webdriver/src/common/log.dart';
export 'package:webdriver/src/common/mouse.dart';
export 'package:webdriver/src/common/spec.dart';

final Uri defaultUri = Uri.parse('http://127.0.0.1:4723/wd/hub/');

/// Creates a new async WebDriver.
///
/// This is intended for internal use! Please use [createDriver] from
/// async_io.dart.
Future<AppiumWebDriver> createDriver(
    AsyncRequestClient Function(Uri prefix) createRequestClient,
    {Uri uri,
    Map<String, dynamic> desired,
    WebDriverSpec spec = WebDriverSpec.Auto}) async {
  uri ??= defaultUri;

  // This client's prefix at root, it has no session prefix in it.
  final client = createRequestClient(uri);

  final handler = getHandler(spec);

  final session = await client.send(
      handler.session.buildCreateRequest(desired: addAppiumPrefix(desired)),
      handler.session.parseCreateResponse);

  if (session.spec != WebDriverSpec.JsonWire &&
      session.spec != WebDriverSpec.W3c) {
    throw 'Unexpected spec: ${session.spec}';
  }

  var newUri = updateUriWithDirectConnect(uri, session.capabilities);

  return AppiumWebDriver(
      newUri,
      session.id,
      UnmodifiableMapView(session.capabilities),
      createRequestClient(newUri.resolve('session/${session.id}/')),
      session.spec);
}

/// Return new URI which has been applied directXxxxx
Uri updateUriWithDirectConnect(
    Uri currentUri, Map<String, dynamic> capabilities) {
  final protocol = 'directConnectProtocol';
  final host = 'directConnectHost';
  final port = 'directConnectPort';
  final path = 'directConnectPath';

  if (capabilities.containsKey(protocol) &&
      capabilities.containsKey(host) &&
      capabilities.containsKey(port) &&
      capabilities.containsKey(path)) {
    return Uri.parse(
        '${capabilities[protocol]}://${capabilities[host]}:${capabilities[port]}${capabilities[path]}');
  }

  return currentUri;
}

/// Returns desired capabilities with appium prefix
Map<String, dynamic> addAppiumPrefix(Map<String, dynamic> desired) {
  var w3cCapabilities = [
    'browserName',
    'browserVersion',
    'platformName',
    'acceptInsecureCerts',
    'pageLoadStrategy',
    'proxy',
    'setWindowRect',
    'timeouts',
    'unhandledPromptBehavior',
    'strictFileInteractability'
  ];

  return desired.map((k, v) {
    if (w3cCapabilities.contains(k) || k.contains(':')) {
      return MapEntry(k, v);
    }
    return MapEntry('appium:$k', v);
  });
}

/// Creates a sync WebDriver from existing session.
///
/// This is intended for internal use! Please use [fromExistingSession] from
/// sync_io.dart.
Future<AppiumWebDriver> fromExistingSession(
    AsyncRequestClient Function(Uri prefix) createRequestClient,
    String sessionId,
    {Uri uri,
    WebDriverSpec spec = WebDriverSpec.Auto}) async {
  uri ??= defaultUri;

  // This client's prefix at root, it has no session prefix in it.
  final client = createRequestClient(uri);

  final handler = getHandler(spec);

  final session = await client.send(handler.session.buildInfoRequest(sessionId),
      handler.session.parseInfoResponse);

  if (session.spec != WebDriverSpec.JsonWire &&
      session.spec != WebDriverSpec.W3c) {
    throw 'Unexpected spec: ${session.spec}';
  }

  var newUri = updateUriWithDirectConnect(uri, session.capabilities);

  return AppiumWebDriver(
      newUri,
      sessionId,
      UnmodifiableMapView(session.capabilities),
      createRequestClient(newUri.resolve('session/$sessionId/')),
      session.spec);
}

/// Creates an async WebDriver from existing session with a sync function.
///
/// This will be helpful when you can't use async when creating WebDriver. For
/// example in a consctructor.
///
/// This is intended for internal use! Please use [fromExistingSessionSync] from
/// async_io.dart or async_html.dart.
AppiumWebDriver fromExistingSessionSync(
    AsyncRequestClient Function(Uri prefix) createRequestClient,
    String sessionId,
    WebDriverSpec spec,
    {Uri uri,
    Map<String, dynamic> capabilities}) {
  uri ??= defaultUri;

  capabilities ??= Capabilities.empty;

  if (spec != WebDriverSpec.JsonWire && spec != WebDriverSpec.W3c) {
    throw 'Unexpected spec: $spec';
  }

  return AppiumWebDriver(uri, sessionId, UnmodifiableMapView(capabilities),
      createRequestClient(uri.resolve('session/$sessionId/')), spec);
}
