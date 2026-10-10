# appium_driver

![Dart CI](https://github.com/KazuCocoa/appium_dart/workflows/Dart%20CI/badge.svg?branch=main)

An appium binding in Dart

Requires Dart 3.4 or later (before Dart 4).

The client uses the W3C protocol (`WebDriverSpec.W3c` or `Auto`).
`WebDriverSpec.JsonWire` is unsupported and throws `UnsupportedError`.
The default server URL is `http://127.0.0.1:4723/`, matching Appium 2 and 3.
For a server configured with another base path, pass its URL explicitly,
including the trailing slash (for example, `http://127.0.0.1:4723/wd/hub/`).

Session discovery and log retrieval use `/appium/sessions`, `/se/log/types`,
and `/se/log`, with fallback to the older endpoints only when the server reports
an unknown command or method. Appium 3 session discovery requires starting the
server with `--allow-insecure='*:session_discovery'`.

Other legacy device endpoints depend on the installed Appium driver and version.
Appium 3 removed several of these endpoints; use the corresponding driver
`mobile:` execute methods where needed (for example,
`driver.execute('mobile: pressKey', [{'keycode': 66}])`). See the
[Appium 3 endpoint migration guide](https://appium.io/docs/en/latest/guides/migrating-2-to-3/#endpoint-changes).

Element attribute lookups return `String?`: an absent attribute is `null`,
distinct from the literal string `'null'`. Android key event methods
`pressKeycodeWithBitmasks` and `longPressKeycodeWithBitmasks` accept integer
`metastate` and `flags` bitmasks, for example
`driver.device.pressKeycodeWithBitmasks(66, metastate: 1 | 2, flags: 32)`.
The original `pressKeycode` and `longPressKeycode` methods still accept lists,
but are deprecated. For example,
`driver.device.pressKeycode(66, metastate: [1, 2], flags: [32])` remains valid;
list entries are combined with bitwise OR before sending. Empty lists produce
zero, and omitted or null arguments are not sent.
Call `driver.quit()` to end the session and close the client's connection, or
`driver.quit(closeSession: false)` to disconnect while keeping the server session.

# About

Flutter has [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) which runs UI tests like Espresso/EarlGrey/Appium for Flutter elements.
The driver is really awesome, but it can automate only flutter view. It cannot handle outside Flutter.

This client aims to be able to write test cases in Dart for Appium.
It may help to write test code with the same programming language as the production code.

# Example

Take a look at [functional tests](./test/functional)

# Lint

```
$ dart analyze
```

# format

```
$ dart format .
```

# pana (analyze on pub.dev)

```
$ dart run pana .
```

# Run tests
## Get dependencies

```
$ dart pub get
```

## Functional

```
$ dart test test/functional
```

## Unit

```
$ dart test test/unit
```

## release

1. Bump the version in `pubspec.yaml`.
2. Move the changes under `Unreleased` in `CHANGELOG.md`
   to a section with the release version and date.
3. Verify CI passes on the minimum supported Dart SDK and stable.
4. Run `dart pub publish --dry-run` and review files and warnings.
5. Commit the release changes.
6. Run `dart pub publish`.
7. Tag the release commit and push the tag.

## Supported Commands

### WebDriver commands

Please refer [webdriver.dart APIs](/)https://pub.dev/documentation/webdriver/latest

- Some W3C actions
    - https://pub.dev/documentation/webdriver/latest/webdriver.io/Mouse-class.html
    - https://github.com/google/webdriver.dart/blob/6d7943ef098d3c938b1f4da5a8590fe827f3dd80/lib/src/handler/w3c/mouse.dart

### Appium actions

All W3C webdriver commands are available such as find_element/s, click and send keys.
Below Appium specific commands are implementing.

- [x] directConnectXxxx
- [x] batch command
- [x] CDP command: `[HttpMethod.httpPost, 'session/:session_id/goog/cdp/execute']`
- [x] `[HttpMethod.httpGet, 'sessions']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/contexts']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/context']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/context']`
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/value']`~~ Deprecated.
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/replace_value']`~~ Deprecated.
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/launch']`~~ Deprecated
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/close']`~~ Deprecated
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/reset']`~~ Deprecated
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/background']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/strings']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/is_locked']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/unlock']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/lock']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/system_time']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/install_app']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/remove_app']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/app_installed']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/activate_app']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/terminate_app']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/app_state']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/shake']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/hide_keyboard']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/press_keycode']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/long_press_keycode']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/push_file']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_file']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_folder']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/get_clipboard']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/set_clipboard']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/settings']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/settings']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/is_keyboard_shown']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/open_notifications']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/start_activity']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_activity']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_package']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/system_bars']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/display_density']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/stop_recording_screen']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/start_recording_screen']`
- [x] `[HttpMethod.httpGet, 'status']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/element/:id/displayed']`
- [x] `[HttpMethod.httpGet, 'session/:session_id']`
- [x] `[HtMethod.httpGet, 'session/:session_id/location']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/location']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/available_engines']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/active_engine']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/activated']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/ime/deactivate']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/ime/activate']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/log/types']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/log']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/events']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/log_event']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/orientation']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/orientation']`
- [x] Add finder for https://github.com/truongsinh/appium-flutter-driver

Low priority

Most of the commands below are available via extension commands, starting with `mobile:` in https://github.com/appium/appium-uiautomator2-driver, for example. Thus, they would not be implemented.

- ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/touch/perform']`~~ # W3C actions should be an alternative
- ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/touch/multi/perform']`~~ # W3C actions should be an alternative
- ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/keyevent']`~~ # Only for Selendroid
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/finger_print']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/compare_images']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/toggle_airplane_mode']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/toggle_wifi']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/toggle_data']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/toggle_location_services']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/app/end_test_coverage']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/performanceData/types']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/getPerformanceData']`
- [ ] `[HttpMethod.httpGet, 'session/:session_id/network_connection']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/network_connection']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/send_sms']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/gsm_call']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/gsm_signal']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/gsm_voice']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/network_speed']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/power_capacity']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/power_ac']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/simulator/touch_id']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/simulator/toggle_touch_id_enrollment']`
- ~~[ ] `[HtMethod.httpGet, 'session/:session_id/timeouts']`~~ <= already has
- ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/keys']`~~ <= will be deprecated in W3C. Use W3C actions instead.

