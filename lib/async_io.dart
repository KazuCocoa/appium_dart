library appium_driver.io;

import 'dart:async' show Future;

import 'package:appium_driver/async_core.dart' as core
    show createDriver, fromExistingSession, fromExistingSessionSync;
import 'package:appium_driver/async_io.dart';

export 'package:appium_driver/async_core.dart'
    hide createDriver, fromExistingSession, fromExistingSessionSync;
export 'package:webdriver/src/request/async_io_request_client.dart';

/// Creates a new async WebDriver using [AsyncIoRequestClient].
///
/// This will bring in dependency on `dart:io`.
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
Future<AppiumWebDriver> createDriver(
        {Uri? uri,
        required Map<String, dynamic> desired,
        WebDriverSpec spec = WebDriverSpec.Auto}) =>
    core.createDriver((prefix) => AsyncIoRequestClient(prefix),
        uri: uri, desired: desired, spec: spec);

/// Creates an async WebDriver from existing session using
/// [AsyncIoRequestClient].
///
/// This will bring in dependency on `dart:io`.
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the

Future<AppiumWebDriver> fromExistingSession(String sessionId,
        {Uri? uri,
        WebDriverSpec spec = WebDriverSpec.Auto,
        Map<String, dynamic>? capabilities}) =>
    core.fromExistingSession(
        (prefix) => AsyncIoRequestClient(prefix), sessionId,
        uri: uri, spec: spec);

/// Creates an async WebDriver from existing session with a sync function using
/// [AsyncIoRequestClient].
///
/// The function is sync, so all necessary information ([sessionId], [spec],
/// [capabilities]) has to be given. Because otherwise, making a call to
/// WebDriver server will make this function async.
///
/// This will bring in dependency on `dart:io`.
/// Note: WebDriver endpoints will be constructed using [resolve] against
/// [uri]. Therefore, if [uri] does not end with a trailing slash, the
/// last path component will be dropped.
AppiumWebDriver fromExistingSessionSync(String sessionId, WebDriverSpec spec,
        {Uri? uri, Map<String, dynamic>? capabilities}) =>
    core.fromExistingSessionSync(
        (prefix) => AsyncIoRequestClient(prefix), sessionId, spec,
        uri: uri, capabilities: capabilities);
