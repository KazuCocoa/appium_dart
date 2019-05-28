library appium_dart.core;

import 'dart:async' show Future;
import 'dart:collection' show UnmodifiableMapView;

import 'package:webdriver/async_core.dart';
import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/src/common/utils.dart';
import 'package:webdriver/src/common/session.dart';

import 'package:appium_dart/src/driver.dart';

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
    if(w3cCapabilities.contains(k) && k.contains(':')) {
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

  return AppiumWebDriver(uri, session.id, UnmodifiableMapView(session.capabilities),
      createRequestClient(uri.resolve('session/${session.id}/')), session.spec);
}

/// Creates a sync WebDriver from existing session.
///
/// This is intended for internal use! Please use [fromExistingSession] from
/// sync_io.dart.
Future<AppiumWebDriver> fromExistingSession(String sessionId,
    AsyncRequestClient Function(Uri prefix) createRequestClient,
    {Uri uri,
      WebDriverSpec spec = WebDriverSpec.Auto,
      Map<String, dynamic> capabilities}) async {
  uri ??= defaultUri;

  var session = SessionInfo(sessionId, spec, capabilities);

  // Update session info if not all is provided.
  if (spec == WebDriverSpec.Auto || capabilities == null) {
    // This client's prefix at root, it has no session prefix in it.
    final client = createRequestClient(uri);

    final handler = getHandler(spec);

    session = await client.send(handler.session.buildInfoRequest(sessionId),
        handler.session.parseInfoResponse);
  }

  if (session.spec != WebDriverSpec.JsonWire &&
      session.spec != WebDriverSpec.W3c) {
    throw 'Unexpected spec: ${session.spec}';
  }

  return AppiumWebDriver(uri, session.id, UnmodifiableMapView(session.capabilities),
      createRequestClient(uri.resolve('session/${session.id}/')), session.spec);
}
