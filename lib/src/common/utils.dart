import 'package:appium_driver/src/handler/w3c_handler.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/spec.dart'; // ignore: implementation_imports

// TODO: will be AppiumWebDriverHandler
AppiumWebDriverHandler getHandler(WebDriverSpec spec) {
  switch (spec) {
    case WebDriverSpec.JsonWire:
      throw UnsupportedError(
          'JSON Wire Protocol is not supported. Use WebDriverSpec.W3c or Auto.');
    case WebDriverSpec.W3c:
      return W3cWebDriverHandler();
    case WebDriverSpec.Auto:
      return W3cWebDriverHandler(); // TODO: will apply only W3C spec
  }
}

class Location {
  final dynamic latitude;
  final dynamic longitude;
  final dynamic altitude;

  /// Handle Location
  Location(this.latitude, this.longitude, this.altitude);
}
