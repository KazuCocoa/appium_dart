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

  test('device lock', () async {
    expect(await driver.device.isLocked(), false);

    await driver.device.lock();
    expect(await driver.device.isLocked(), true);

    await driver.device.unlock();
    expect(await driver.device.isLocked(), false);

    await driver.device.lock(seconds: Duration(seconds: 2));
    // wait 2 sec
    expect(await driver.device.isLocked(), false);

    var time = await driver.device.getSystemTime();
    expect(DateTime.parse(time) is DateTime, true); // Can parse without error
  });

  test('keyboard', () async {
    await driver.keyboard.hide();
    expect(await driver.keyboard.isShown(), false);
  });

  test('keycode', () async {
    // can run without error
    await driver.device.pressKeycode(66, metastate: [1], flags: [32]);
    await driver.device.longPressKeycode(66, metastate: [1], flags: [32]);
  });

  test('open notification', () async {
    // Make sure it does not raise error
    await driver.device.openNotification();
  });
}
