import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.iOSDesiredCapabilitiesApp);
    await driver.timeouts.setImplicitTimeout(Duration(seconds: 5));
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('Click a button', () async {
    final buttons = 'Buttons';
    final gray = 'Gray';
    final textView = 'TextView';

    var element = await driver.findElement(AppiumBy.accessibilityId(buttons));
    await element.click();

    await driver.findElement(AppiumBy.name(gray));
    await driver.back();

    await driver.findElement(AppiumBy.accessibilityId(textView));
  });

  test('shake', () async {
    await driver.device.shake();
  });
}
