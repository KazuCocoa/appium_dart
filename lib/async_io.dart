library appium_dart.io;

import 'dart:async' show Future;

import 'package:appium_dart/async_core.dart' as core
      show createDriver, fromExistingSession;
import 'package:appium_dart/async_io.dart';
import 'package:appium_dart/src/driver.dart';


export 'package:webdriver/async_core.dart'
    hide createDriver, fromExistingSession, fromExistingSessionSync;
export 'package:webdriver/src/request/async_io_request_client.dart';
import 'package:webdriver/async_core.dart';

/// Public method
Future<AppiumWebDriver> createDriver(
    {Uri uri,
    Map<String, dynamic> desired,
    WebDriverSpec spec = WebDriverSpec.Auto}) =>
    core.createDriver((prefix) => AsyncIoRequestClient(prefix),
        uri: uri, desired: desired, spec: spec);

Future<AppiumWebDriver> fromExistingSession(String sessionId,
    {Uri uri,
      WebDriverSpec spec = WebDriverSpec.Auto,
      Map<String, dynamic> capabilities}) =>
    core.fromExistingSession(
        sessionId, (prefix) => AsyncIoRequestClient(prefix),
        uri: uri, spec: spec, capabilities: capabilities);
