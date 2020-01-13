import 'dart:async';

import 'package:appium_driver/src/async/web_driver.dart';
import 'package:appium_driver/src/common/by.dart';
import 'package:appium_driver/src/async/web_element.dart';

typedef GetAttribute = Future<String> Function(String name);

/// Simple class to provide access to indexed properties such as WebElement
/// attributes or css styles.
class Attributes {
  final GetAttribute _getAttribute;

  Attributes(this._getAttribute);

  Future<String> operator [](String name) => _getAttribute(name);
}

abstract class SearchContext {
  AppiumWebDriver get driver;

  /// Searches for multiple elements within the context.
  Stream<AppiumWebElement> findElements(AppiumBy by);

  /// Searches for an element within the context.
  ///
  /// Throws [NoSuchElementException] if no matching element is found.
  Future<AppiumWebElement> findElement(AppiumBy by);
}
