import 'dart:async';

import 'package:appium_dart/async_core.dart';
import 'package:appium_dart/src/common/by.dart';

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
  Stream<AppiumWebElement> findElements(AppiumBy by);

  Future<AppiumWebElement> findElement(AppiumBy by);
}
