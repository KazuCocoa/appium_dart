import 'dart:async';

import 'package:appium_driver/async_core.dart';
import 'package:appium_driver/src/common/by.dart';

// For MJSONWP
const String jsonWireElementStr = 'ELEMENT';

// For W3C
const String w3cElementStr = 'element-6066-11e4-a52e-4f735466cecf';

typedef GetAttribute = Future<String?> Function(String name);

/// Simple class to provide access to indexed properties such as WebElement
/// attributes or css styles.
class Attributes {
  final GetAttribute _getAttribute;

  Attributes(this._getAttribute);

  Future<String?> operator [](String name) => _getAttribute(name);
}

abstract class AppiumSearchContext {
  AppiumWebDriver get driver;

  /// Searches for multiple elements within the context
  Stream<AppiumWebElement> findElements(AppiumBy by);

  Future<AppiumWebElement> findElement(AppiumBy by);
}
