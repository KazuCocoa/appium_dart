import 'package:appium_driver/src/async/web_driver.dart';

import 'package:webdriver/sync_core.dart' as sync_core;

/// Returns a [sync_core.WebDriver] with the same URI + session ID.
sync_core.WebDriver createSyncWebDriver(AppiumWebDriver driver) =>
    throw 'Not implemented';
