import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.androidDesiredCapabilitiesApp);
    await driver.timeouts.setImplicitTimeout(const Duration(seconds: 5));
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

    await driver.device.lock(seconds: const Duration(seconds: 2));
    // wait 2 sec
    expect(await driver.device.isLocked(), false);

    var time = await driver.device.getSystemTime();
    // ignore: unnecessary_type_check
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

  test('start activity', () async {
    await driver.app.background(seconds: const Duration(seconds: -1));
    expect(
        await driver.appState.get('io.appium.android.apis') !=
            AppState.RunningInForeground,
        true);
    await driver.device.startActivity(
        appPackage: 'io.appium.android.apis',
        appActivity: 'io.appium.android.apis.ApiDemos');
    expect(await driver.appState.get('io.appium.android.apis'),
        AppState.RunningInForeground);

    expect('io.appium.android.apis', await driver.device.getCurrentPackage());
    expect('.ApiDemos', await driver.device.getCurrentActivity());
  });

  test('location', () async {
    Location l = await driver.device.getLocation();
    expect(l.longitude != null, true);
    expect(l.altitude != null, true);
    expect(l.latitude != null, true);
    await driver.device.setLocation(Location(100.0, 30.0, 0.0));
  });

  test('get bars and display denticyr', () async {
    var systemBar = await driver.device.getSystemBars();
    expect(systemBar['statusBar'] != null, true);
    expect(systemBar['navigationBar'] != null, true);

    // ignore: unnecessary_null_comparison
    expect(await driver.device.getDisplayDensity() != null, true);
  });

  test('logs', () async {
    var logType = await driver.logs.getAvailableType();
    var logs = driver.logs.get(logType.first);
    expect((await logs.take(1).toList()).length, 1);
//    expect(logs.take(1).message.isEmpty, false);

    await driver.logs.logEvent('custom', 'event');
    // {commands: [{cmd: timeouts, startTime: 1575388557299, endTime: 1575388557300}, {cmd: getLogTypes, startTime: 1575388557313, endTime: 1575388557313}, {cmd: getLog, startTime: 1575388557326, endTime: 1575388557326}, {cmd: logCustomEvent, startTime: 1575388557453, endTime: 1575388557454}, {cmd: getLogEvents, startTime: 1575388557458, endTime: 1575388557459}],
    // custom:event: [1575388557453]}
    var result = await driver.logs.getEvents();
    expect(result['commands'].length > 1, true);
    result = await driver.logs.getEvents(type: 'custom:event');
    expect(result['custom:event'].length == 1, true);
  });

  test('cdp', () async {
    await driver.device.startActivity(
        appPackage: 'io.appium.android.apis',
        appActivity: 'io.appium.android.apis.view.WebView1');
    var contexts = await driver.contexts.getAvailableContexts();
    await driver.contexts.setContext(contexts[1]);

    var response = await driver.cdp.execute('Page.getResourceTree', {});
    expect(response['frameTree'] != null, true);

    response = await driver.cdp
        .execute('Page.captureScreenshot', {'quality': 1, 'format': 'jpeg'});
    expect(response['data'].startsWith('/9j/'), true);
  });
}
