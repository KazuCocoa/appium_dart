import 'dart:convert';

import 'package:appium_driver/src/common/orientation.dart';
import 'package:test/test.dart';

import 'package:appium_driver/async_io.dart';

import 'helper.dart';

void main() {
  late AppiumWebDriver driver;

  setUpAll(() async {
    driver = await createDriver(
        uri: TestHelper.localServer,
        desired: TestHelper.iOSDesiredCapabilitiesApp);
    await driver.timeouts.setImplicitTimeout(const Duration(seconds: 5));
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('Click a button', () async {
    final buttons = 'Buttons';
    final xButton = 'X Button';
    final alertViews = 'Alert Views';

    var element = await driver.findElement(AppiumBy.accessibilityId(buttons));
    // ignore: unnecessary_null_comparison
    expect(element.id != null, true);
    await element.click();

    expect(await element.displayed, true);

    await driver.findElement(AppiumBy.name(xButton));
    await driver.back();

    await driver.findElement(AppiumBy.accessibilityId(alertViews));
  });

  test('set value', () async {
    final textFieldCell = 'Text Fields';
    final textField = 'Placeholder text';
    final xcuielementTextField = 'XCUIElementTypeTextField';

    await driver.execute('mobile: scroll', [
      {'direction': 'down'}
    ]);

    var element =
        await driver.findElement(AppiumBy.accessibilityId(textFieldCell));
    await element.click();

    element = await driver
        .findElement(AppiumBy.predicateString('value == \"$textField\"'));
    await element.sendKeys('hello');

    element =
        await driver.findElement(AppiumBy.className(xcuielementTextField));
    expect(await element.text, 'hello');
  });

  test('shake', () async {
    await driver.device.shake();
  });

  test('settings', () async {
    await driver.settings.update({
      'fixImageFindScreenshotDims': true,
      'autoUpdateImageElementPosition': false
    });
    expect((await driver.settings.get())['fixImageFindScreenshotDims'], true);
  });

  test('status', () async {
    var s = await driver.status.get();
    expect(s['build'] != null, true);
  });

  test('capabilities', () async {
    var capabilities = await driver.session.getCapabilities();
    expect(capabilities['automationName'].toString().toLowerCase(), 'xcuitest');
  });

  test('push and pull', () async {
    var pulledFile = await driver.device
        .pullFile('Library/AddressBook/AddressBook.sqlitedb');
    var pulFolder = await driver.device.pullFolder('Library/AddressBook');
    expect(pulledFile.isNotEmpty, true);
    expect(pulFolder.isNotEmpty, true);

    await driver.device.pushFile('AddressBook.png', pulledFile);
  });

  test('clipboard', () async {
    await driver.device
        .setClipboard(base64.encode(utf8.encode('happy testing')));
    expect(utf8.decode(base64.decode(await driver.device.getClipboard())),
        'happy testing');

    await driver.device.setClipboard(base64.encode(utf8.encode('appium')));
    expect(utf8.decode(base64.decode(await driver.device.getClipboard())),
        'appium');
  });

  // Requires '--relaxed-security' or '--allow-insecure=execute_driver_script'
  test('execute driver', () async {
    expect(await driver.executeDriver('''
const status = await driver.status();
console.warn('warning message');
return [status];
    ''', type: 'webdriverio', timeout: const Duration(minutes: 1)), {
      'result': [
        {
          'build': {'version': '1.20.2'}
        }
      ],
      'logs': {
        'error': [],
        'warn': ['warning message'],
        'log': []
      }
    });

    expect(await driver.executeDriver('''
const status = await driver.status();
console.warn('warning message');
return [status];
    '''), {
      'result': [
        {
          'build': {'version': '1.20.2'}
        }
      ],
      'logs': {
        'error': [],
        'warn': ['warning message'],
        'log': []
      }
    });
  });

  test('orientation', () async {
    expect(await driver.device.getOrientation(), Orientation.PORTRAIT);
    await driver.device.setOrientation(Orientation.LANDSCAPE);
    expect(await driver.device.getOrientation(), Orientation.LANDSCAPE);
    await driver.device.setOrientation(Orientation.PORTRAIT);
  });
}
