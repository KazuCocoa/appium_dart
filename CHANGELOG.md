## [Unreleased]

## [0.6.1] - 2023-08-19
- Expose finder

## [0.6.0] - 2023-03-22
- Add drag guestur in mouse [#49](https://github.com/KazuCocoa/appium_dart/pull/49)

## [0.5.3] - 2022-11-04
- Improved error message handling when the server responded as MJSONWP protocol instead of valid W3C error response

## [0.5.2] - 2021-11-14
- Fix format with Dart 2.14.4
- Excludeds `test` directory from the published package

## [0.5.1] - 2021-11-06
- Deprecate `launchApp`, `closeApp` and `reset`. Please read [appium/issues#15807](https://github.com/appium/appium/issues/15807) for more details.

## [0.5.0] - 2021-09-13
- Add `firstMatchOnly` parameter in `byAncestor` and `byDescendant`

## [0.4.1] - 2021-07-14
- Fix `byAncestor` and `byDescendant`

## [0.4.0] - 2021-05-30
- Add `AppiumFlutterFinder` for https://github.com/truongsinh/appium-flutter-driver
    - Please read test/unit/flutter_finder_test.dart or their docstring about their usage.

## [0.3.1](0.3.0) - 2021-03-12

- Tried to null safe

## [0.2.2] - 2021-01-10

This version is same as 0.2.0 and 0.2.1. (To update documentation)

- Add `driver.executeDriver`
- Add `driver.device.getOrientation` and `driver.device.setOrientation`

## [0.1.4] - 2020-06-18

- Add `driver.cdp.execute` command to call ChromeDevTools command in WebView context
- Add `-android viewmatcher` as `await driver.findElement(AppiumBy.viewmatcher('view matcher'))`
    ```dart
    import 'dart:convert';
    var cmd = json.encode({
      'name': 'withText',
      'args': ['Accessibility'],
      'class': 'androidx.test.espresso.matcher.ViewMatchers'
    });
    var e = await driver.findElement(AppiumBy.viewmatcher(cmd));
    ```
- Fix to send `text` as `setImmediateValue` and `replaceText` for backward compatibility
    - `sendKeys` already has it


## [0.1.3] - 2020-02-12

- Chore: Fix formatter warning

## [0.1.2] - 2020-01-14

- Add events methods: `driver.logs.getEvents`, `driver.logs.logEvent`
- Fix warning message by static analyzer

## [0.1.1] - 2019-08-7

- Fix parsing element/s by find element/s which have only MJSONWP key

## [0.1.0] - 2019-07-14

Basic actions have been implemented.

- Add location methods: `driver.device.getLocation`, `driver.device.setLocation`
- Add system bars and density: `driver.device.getSystemBars`, `driver.device.getDisplayDensity`
- Add log methods for Appium: `driver.logs.getAvailableType`, `driver.logs.get`

## [0.0.7] - 2019-07-07
- Add get sessions command: `driver.sessions.get()`
- Add get status: `driver.status.get()`
- Add get capabilities: `driver.session.getCapabilities()`
- Add push/pull files and folder: `driver.device.pushFile`, `driver.device.pullFile`, `driver.device.pullFolder`
- Add set/get clipboard: `driver.device.setClipboard`, `driver.device.getClipboard`
- Add open notification: `driver.device.openNotification`
- Add start activity: `driver.device.startActivity`
- Add get current activity/package: `driver.device.getCurrentPackage`, `driver.device.getCurrentActivity`

## [0.0.6] - 2019-06-30
- Add device lock related commands: `driver.device.*`
- Add device system time command: `driver.device.getSystemTime()`
- Add device shake command: `driver.device.shake()`
- Add keyboard commands: `driver.keyboard.isShown()` and `driver.keyboard.hide()`
- Add keycode commands: `driver.device.pressKeycode` and `driver.device.longPressKeycode`
- Add element commands: `element.displayed`, `element.replaceValue`, `element.setImmediateValue`
- Add settings commands: `driver.settings.update`, `driver.settings.get`

## [0.0.5] - 2019-06-22
- Add context related commands: `driver.contexts.*`
- Add app state related commands: `driver.appState.*`
- Add app management commands: `driver.app.*`
    - e.g. install, terminate
- Add IME related commands: `driver.ime.*`

## [0.0.4] - 2019-06-19

- Add `driver.contexts.getAvailableContexts()`
- Add `driver.appState.get('com.apple.mobilesafari'))`

## [0.0.3] - 2019-06-03

- Add an example

## [0.0.2] - 2019-06-03

- Apply formatter

## [0.0.1] - 2019-06-02

- initial release
