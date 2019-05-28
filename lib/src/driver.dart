import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/sync_core.dart';

class AppiumWebDriver extends WebDriver {
  AppiumWebDriver(Uri uri, String id, Map<String, dynamic> capabilities, SyncRequestClient client, WebDriverSpec spec) : super(uri, id, capabilities, client, spec);
}
