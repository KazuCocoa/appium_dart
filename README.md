# appium_driver

![Dart CI](https://github.com/KazuCocoa/appium_dart/workflows/Dart%20CI/badge.svg?branch=main)

An Appium client for writing UI tests in Dart, including interactions outside
Flutter views.

- [Getting started](#getting-started)
- [Appium compatibility](#appium-compatibility)
- [API notes and migration](#api-notes-and-migration)
- [Supported commands](#supported-commands)
- [Development](#development)
- [Release](#release)

## Getting started

### Requirements and installation

Requires Dart 3.4 or later (before Dart 4).

Add the package to your Dart project:

```sh
dart pub add appium_driver
```

### Server URL

The default server URL is `http://127.0.0.1:4723/`, matching Appium 2 and 3.
For a server configured with another base path, pass its URL explicitly,
including the trailing slash (for example, `http://127.0.0.1:4723/wd/hub/`).

### Examples and session cleanup

See the [example](./example/main.dart) and [functional tests](./test/functional)
for usage.

Call `driver.quit()` to end the session and close the client's connection, or
`driver.quit(closeSession: false)` to disconnect while keeping the server session.

## Appium compatibility

### Protocol

The client uses the W3C protocol (`WebDriverSpec.W3c` or `Auto`).
`WebDriverSpec.JsonWire` is unsupported and throws `UnsupportedError`.

### Session discovery and logs

Session discovery and log retrieval use `/appium/sessions`, `/se/log/types`,
and `/se/log`, with fallback to the older endpoints only when the server reports
an unknown command or method. Appium 3 session discovery requires starting the
server with `--allow-insecure='*:session_discovery'`.

### Legacy device endpoints

Other legacy device endpoints depend on the installed Appium driver and version.
Appium 3 removed several of these endpoints; use the corresponding driver
`mobile:` execute methods where needed, for example:

```dart
await driver.execute('mobile: pressKey', [{'keycode': 66}]);
```

See the [Appium 3 endpoint migration guide](https://appium.io/docs/en/latest/guides/migrating-2-to-3/#endpoint-changes).

## API notes and migration

### Nullable attributes

Element attribute lookups return `String?`: an absent attribute is `null`,
distinct from the literal string `'null'`.

### Android keycode modifiers

`pressKeycodeWithBitmasks` and `longPressKeycodeWithBitmasks` accept integer
`metastate` and `flags` bitmasks:

```dart
await driver.device.pressKeycodeWithBitmasks(66, metastate: 1 | 2, flags: 32);
```

The original `pressKeycode` and `longPressKeycode` methods still accept lists,
but are deprecated. Existing calls remain valid:

```dart
await driver.device.pressKeycode(66, metastate: [1, 2], flags: [32]);
```

List entries are combined with bitwise OR before sending. Empty lists produce
zero, and omitted or null arguments are not sent.

## Supported commands

### WebDriver commands

See the [webdriver.dart API reference](https://pub.dev/documentation/webdriver/latest).

- Some W3C actions
    - https://pub.dev/documentation/webdriver/latest/webdriver.io/Mouse-class.html
    - https://github.com/google/webdriver.dart/blob/6d7943ef098d3c938b1f4da5a8590fe827f3dd80/lib/src/handler/w3c/mouse.dart

### Appium actions

The client supports W3C commands such as finding elements, clicking, and sending
keys. The list below tracks client implementations; availability on the server
depends on the Appium version and installed driver. See
[Appium compatibility](#appium-compatibility) for limitations.

#### Sessions and contexts

- [x] directConnectXxxx
- [x] batch command
- [x] CDP command: `[HttpMethod.httpPost, 'session/:session_id/goog/cdp/execute']`
- [x] `[HttpMethod.httpGet, 'appium/sessions']` (legacy fallback: `sessions`)
- [x] `[HttpMethod.httpGet, 'session/:session_id/contexts']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/context']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/context']`

#### Legacy element and application commands

- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/value']`~~ Deprecated.
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/replace_value']`~~ Deprecated.
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/launch']`~~ Deprecated
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/close']`~~ Deprecated
- ~~[x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/reset']`~~ Deprecated
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/background']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/strings']`

#### Device and application control

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

#### Files and clipboard

- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/push_file']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_file']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_folder']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/get_clipboard']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/set_clipboard']`

#### Settings and device information

- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/settings']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/settings']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/is_keyboard_shown']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/open_notifications']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/start_activity']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_activity']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_package']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/system_bars']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/display_density']`

#### Screen recording

- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/stop_recording_screen']`
- [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/start_recording_screen']`

#### Status, elements, and location

- [x] `[HttpMethod.httpGet, 'status']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/element/:id/displayed']`
- [x] `[HttpMethod.httpGet, 'session/:session_id']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/location']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/location']`

#### Input methods

- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/available_engines']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/active_engine']`
- [x] `[HttpMethod.httpGet, 'session/:session_id/ime/activated']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/ime/deactivate']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/ime/activate']`

#### Logs and events

- [x] `[HttpMethod.httpGet, 'session/:session_id/se/log/types']` (legacy fallback: `log/types`)
- [x] `[HttpMethod.httpPost, 'session/:session_id/se/log']` (legacy fallback: `log`)
- [x] `[HttpMethod.httpGet, 'session/:session_id/appium/events']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/appium/log_event']`

#### Orientation and Flutter finders

- [x] `[HttpMethod.httpGet, 'session/:session_id/orientation']`
- [x] `[HttpMethod.httpPost, 'session/:session_id/orientation']`
- [x] Add finder for https://github.com/truongsinh/appium-flutter-driver

### Not planned or low priority

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
- ~~[ ] `[HttpMethod.httpGet, 'session/:session_id/timeouts']`~~ <= already has
- ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/keys']`~~ <= will be deprecated in W3C. Use W3C actions instead.

## Development

### Install dependencies

```sh
dart pub get
```

### Analyze and format

```sh
dart analyze
dart format .
```

### Run tests

Unit tests:

```sh
dart test test/unit
```

Functional tests require a running Appium server and a configured device or
emulator. See the setup in [test/functional](./test/functional).

```sh
dart test test/functional
```

### Check package quality

```sh
dart run pana .
```

## Release

1. Bump the version in `pubspec.yaml`.
2. Move the changes under `Unreleased` in `CHANGELOG.md`
   to a section with the release version and date.
3. Verify CI passes on the minimum supported Dart SDK and stable.
4. Run `dart pub publish --dry-run` and review files and warnings.
5. Commit the release changes.
6. Run `dart pub publish`.
7. Tag the release commit and push the tag.
