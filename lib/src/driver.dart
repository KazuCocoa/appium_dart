import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/async_core.dart';

class AppiumWebDriver extends WebDriver {
  AppiumWebDriver(Uri uri, String id, Map<String, dynamic> capabilities, AsyncRequestClient client, WebDriverSpec spec) :
        super(uri, id, capabilities, client, spec);
}
