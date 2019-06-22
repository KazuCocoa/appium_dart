import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.androidDesiredCapabilitiesApp);
    await driver.timeouts.setImplicitTimeout(Duration(seconds: 5));
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('ime', () async {
    var imes = await driver.ime.getAvailableEngines();
    var firstEngine = imes.first;
    expect(imes.isNotEmpty, true);

    expect(await driver.ime.isActivated(), true);

    await driver.ime.activateEngine(firstEngine);

    var activeIme = await driver.ime.getActiveEngine();
    expect(activeIme, firstEngine);

    await driver.ime.deactivate();
    activeIme = await driver.ime.getActiveEngine();
    expect(firstEngine != activeIme, true);

    await driver.ime.activateEngine(firstEngine);
    expect(await driver.ime.getActiveEngine(), firstEngine);
  });
}
