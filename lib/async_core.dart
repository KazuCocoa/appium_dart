library appium_dart.core;

import 'dart:async' show Future;
import 'dart:collection' show UnmodifiableMapView;

import 'package:appium_dart/src/async/web_driver.dart';
import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/src/common/utils.dart';
import 'package:webdriver/src/common/spec.dart';
import 'package:webdriver/src/common/capabilities.dart';

export 'package:appium_dart/async_core.dart';
export 'package:appium_dart/src/async/web_driver.dart';
export 'package:appium_dart/src/async/web_element.dart';
export 'package:appium_dart/src/common/by.dart';
export 'package:appium_dart/src/async/target_locator.dart';

export 'package:webdriver/src/async/alert.dart';
export 'package:webdriver/src/async/cookies.dart';
export 'package:webdriver/src/async/keyboard.dart';
export 'package:webdriver/src/async/logs.dart';
export 'package:webdriver/src/async/mouse.dart';
export 'package:webdriver/src/async/timeouts.dart';
export 'package:webdriver/src/async/window.dart';
export 'package:webdriver/src/common/capabilities.dart';
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

  final desiredCapabilities = new Map<String, dynamic>();
  desired.forEach((k, v) {
    if (w3cCapabilities.contains(k) && k.contains(':')) {
      desiredCapabilities.addAll({k: v});
    } else {
      desiredCapabilities.addAll({'appium:$k': v});
    }
  });

  final session = await client.send(
      handler.session.buildCreateRequest(desired: desiredCapabilities),
      handler.session.parseCreateResponse);

  if (session.spec != WebDriverSpec.JsonWire &&
      session.spec != WebDriverSpec.W3c) {
    throw 'Unexpected spec: ${session.spec}';
  }

  return AppiumWebDriver(
      uri,
      session.id,
      UnmodifiableMapView(session.capabilities),
      createRequestClient(uri.resolve('session/${session.id}/')),
      session.spec);
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

  return AppiumWebDriver(
      uri,
      sessionId,
      UnmodifiableMapView(session.capabilities),
      createRequestClient(uri.resolve('session/${sessionId}/')),
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
      createRequestClient(uri.resolve('session/${sessionId}/')), spec);
}
