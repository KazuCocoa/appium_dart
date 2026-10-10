import 'dart:convert';

import 'package:appium_driver/async_core.dart' as core;
import 'package:appium_driver/src/common/search_context.dart'
    show w3cElementStr;
import 'package:test/test.dart';

import 'support/recording_client.dart';

void main() {
  late RecordingClient client;
  late core.AppiumWebDriver driver;
  setUp(() {
    client = RecordingClient(
        Uri.parse('http://localhost:4723/session/abc/'), (_) => response(null));
    driver = core.AppiumWebDriver(Uri.parse('http://localhost:4723/'), 'abc',
        {}, client, core.WebDriverSpec.W3c);
  });

  for (final dontStop in [true, false, null]) {
    test('startActivity sends an optional boolean: $dontStop', () async {
      await driver.device.startActivity(
        appPackage: 'com.example',
        appActivity: '.MainActivity',
        dontStopAppOnReset: dontStop,
      );
      expect(client.requests.single.uri, 'appium/device/start_activity');
      expect(jsonDecode(client.requests.single.body!), {
        'appPackage': 'com.example',
        'appActivity': '.MainActivity',
        if (dontStop != null) 'dontStopAppOnReset': dontStop,
      });
    });
  }

  test('switches frames using an element reference', () async {
    await driver.switchTo.frame(driver.getElement('iframe-id'));
    expect(client.requests.single.uri, 'frame');
    expect(jsonDecode(client.requests.single.body!), {
      'id': {w3cElementStr: 'iframe-id'}
    });
  });

  for (final frame in [null, 0, 2]) {
    test('preserves frame index/default selection: $frame', () async {
      await driver.switchTo.frame(frame);
      expect(jsonDecode(client.requests.single.body!), {'id': frame});
    });
  }

  test('distinguishes missing attributes from the literal string null',
      () async {
    final values = [null, 'null', '', 'true'];
    client = RecordingClient(Uri.parse('http://localhost/session/abc/'),
        (_) => response(values.removeAt(0)));
    driver = core.AppiumWebDriver(Uri.parse('http://localhost/'), 'abc', {},
        client, core.WebDriverSpec.W3c);
    final element = driver.getElement('element');
    expect(await element.attributes['missing'], isNull);
    expect(await element.attributes['literal'], 'null');
    expect(await element.attributes['empty'], '');
    expect(await element.attributes['checked'], 'true');
  });

  for (final input in ['', 'ab', '日本語', 'a😀𠮷b', core.Keyboard.enter]) {
    test('sends complete Unicode characters: $input', () async {
      await driver.keyboard.sendKeys(input);
      final actions = jsonDecode(client.requests.single.body!)['actions'][0]
          ['actions'] as List;
      final downs = actions
          .where((a) => a['type'] == 'keyDown')
          .map((a) => a['value'] as String)
          .toList();
      final ups = actions
          .where((a) => a['type'] == 'keyUp')
          .map((a) => a['value'] as String)
          .toList();
      expect(downs.join(), input);
      expect(downs.every((key) => key.runes.length == 1), isTrue);
      expect(ups, downs);
    });
  }

  for (final longPress in [false, true]) {
    test('sends integer key event masks, longPress=$longPress', () async {
      if (longPress) {
        await driver.device
            .longPressKeycodeWithBitmasks(66, metastate: 1 | 2, flags: 32);
      } else {
        await driver.device
            .pressKeycodeWithBitmasks(66, metastate: 1 | 2, flags: 32);
      }
      expect(jsonDecode(client.requests.single.body!),
          {'keycode': 66, 'metastate': 3, 'flags': 32});
    });
  }

  test('omits absent key event masks', () async {
    await driver.device.pressKeycodeWithBitmasks(66);
    expect(jsonDecode(client.requests.single.body!), {'keycode': 66});
  });

  for (final longPress in [false, true]) {
    for (final (bits, flags, expectedMask, expectedFlags)
        in <(List<int>?, List<int>?, int?, int?)>[
      (null, null, null, null),
      ([], [], 0, 0),
      ([1], [32], 1, 32),
      ([1, 2], [32], 3, 32),
      ([1, 1, 2], [32, 32, 64], 3, 96),
    ]) {
      test('legacy key modifiers use bitwise OR: $bits, longPress=$longPress',
          () async {
        if (longPress) {
          // ignore: deprecated_member_use_from_same_package
          await driver.device.longPressKeycode(
            66,
            metastate: bits,
            flags: flags,
          );
        } else {
          // ignore: deprecated_member_use_from_same_package
          await driver.device.pressKeycode(66, metastate: bits, flags: flags);
        }
        expect(
            client.requests.single.uri,
            longPress
                ? 'appium/device/long_press_keycode'
                : 'appium/device/press_keycode');
        expect(jsonDecode(client.requests.single.body!), {
          'keycode': 66,
          if (bits != null) 'metastate': expectedMask,
          if (flags != null) 'flags': expectedFlags,
        });
      });
    }

    test('legacy key modifiers can be omitted, longPress=$longPress', () async {
      if (longPress) {
        // ignore: deprecated_member_use_from_same_package
        await driver.device.longPressKeycode(66);
      } else {
        // ignore: deprecated_member_use_from_same_package
        await driver.device.pressKeycode(66);
      }
      expect(jsonDecode(client.requests.single.body!), {'keycode': 66});
    });
  }

  test('can disable and re-enable event notifications', () async {
    var events = 0;
    driver.addEventListener((_) async {
      events++;
    });
    driver.notifyListeners = false;
    await driver.getRequest('probe');
    expect(events, 0);
    driver.notifyListeners = true;
    await driver.getRequest('probe');
    expect(events, 1);
  });

  test('a listener can issue commands without recursive notifications',
      () async {
    var events = 0;
    driver.addEventListener((_) async {
      events++;
      if (events > 1) fail('Recursive notification');
      driver.notifyListeners = false;
      try {
        await driver.getRequest('listener-probe');
      } finally {
        driver.notifyListeners = true;
      }
    });
    await driver.getRequest('probe');
    expect(events, 1);
    expect(client.requests.map((r) => r.uri), ['probe', 'listener-probe']);
  });

  for (final closeSession in [true, false]) {
    test('quit closes the client with closeSession=$closeSession', () async {
      await driver.quit(closeSession: closeSession);
      expect(client.closeCount, 1);
      expect(client.requests.length, closeSession ? 1 : 0);
    });
  }

  test('quit closes the client even if deletion fails', () async {
    client = RecordingClient(Uri.parse('http://localhost/session/abc/'),
        (_) => errorResponse('invalid session id'));
    driver = core.AppiumWebDriver(Uri.parse('http://localhost/'), 'abc', {},
        client, core.WebDriverSpec.W3c);
    await expectLater(
        driver.quit(), throwsA(isA<core.InvalidSessionIdException>()));
    expect(client.closeCount, 1);
  });
}
