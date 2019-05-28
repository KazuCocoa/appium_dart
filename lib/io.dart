library appium_dart.io;

import 'package:webdriver/src/request/sync_http_request_client.dart';

import 'package:webdriver/sync_core.dart';
import 'appium_dart.dart';
import 'package:appium_dart/src/driver.dart';

/// Public method
AppiumWebDriver createDriver(
    {Uri uri,
      Map<String, dynamic> desired,
      WebDriverSpec spec = WebDriverSpec.Auto}) =>
    createDriverCore((prefix) => SyncHttpRequestClient(prefix),
        uri: uri, desired: desired, spec: spec);

AppiumWebDriver fromExistingSession(String sessionId,
    {Uri uri,
      WebDriverSpec spec = WebDriverSpec.Auto,
      Map<String, dynamic> capabilities}) =>
    fromExistingSessionCore(
        sessionId, (prefix) => SyncHttpRequestClient(prefix),
        uri: uri, spec: spec, capabilities: capabilities);
