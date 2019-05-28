import 'dart:async';

import 'package:webdriver/async_core.dart';

import 'package:appium_dart/src/driver.dart';
import 'by.dart';

typedef GetAttribute = Future<String> Function(String name);

/// Simple class to provide access to indexed properties such as WebElement
/// attributes or css styles.
class Attributes {
  GetAttribute _getAttribute;

  Attributes(this._getAttribute);

  Future<String> operator [](String name) => _getAttribute(name);
}

abstract class AppiumSearchContext {
  AppiumWebDriver get driver;

  /// Searches for multiple elements within the context
  Stream<WebElement> findElements(AppiumBy by);

  Future<WebElement> findElement(AppiumBy by);
}
