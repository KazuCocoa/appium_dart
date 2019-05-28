import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/async_core.dart';

import 'package:webdriver/src/common/spec.dart';
export 'package:webdriver/src/common/spec.dart';

class AppiumWebDriver extends WebDriver {
  AppiumWebDriver(Uri uri, String id, Map<String, dynamic> capabilities, AsyncRequestClient client, WebDriverSpec spec) :
        super(uri, id, capabilities, client, spec);
}
