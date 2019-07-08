# appium_driver

[![Build Status](https://api.cirrus-ci.com/github/KazuCocoa/appium_dart.svg)](https://cirrus-ci.com/github/KazuCocoa/appium_dart)

This is not a stable project yet.

An appium client in Dart

# Why

Flutter has [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) which runs UI tests like Espresso/EarlGrey/Appium.
The driver is really awesome, but it can automate only flutter view. It cannot handle outside Flutter.

According to some issues on the Flutter repo, they have a plan to make findable Flutter elements by Espresso/EarlGrey framework.
But it means test cases should be Java/Kotlin or Swift/Objective-C.
After the change, Appium also can handle elements via UIA2 or Espresso driver and XCUITest driver though.

I assumed users, who use Flutter fully or a part of, would like to implement UI tests in Dart.

Hence, this repository is another PoC for calling flutter_driver via HTTP requests in https://github.com/KazuCocoa/proto-flutter-driver-server

# Example

Take a look at [functional tests](./test/functional)

# Lint

```
$ dartanalyzer --options analysis_options.yaml .
```

# format

```
$ dartfmt -w --fix .
```

# Run tests
## Get dependencies

```
$ pub get
```

## Functional

```
$ pub run test test/functional
```

## Unit

```
$ pub run test test/unit
```

## release
- Bump the version in `pubspec.yml`
- Run `pub publish`

## TODO

All W3C webdriver commands are available such as find_element/s, click and send keys.
Below Appium specific commands are implementing.

- [ ] Add appium commands
    - [x] directConnectXxxx
    - [x] `[HttpMethod.httpGet, 'sessions']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/contexts']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/context']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/context']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/touch/perform']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/touch/multi/perform']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/value']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/element/:id/replace_value']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/launch']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/close']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/app/reset']`
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
    - ~~[ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/keyevent']`~~ # Only for Selendroid 
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/push_file']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_file']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/pull_folder']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/get_clipboard']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/set_clipboard']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/finger_print']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/appium/settings']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/settings']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/stop_recording_screen']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/start_recording_screen']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/compare_images']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/is_keyboard_shown']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/open_notifications']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/appium/device/toggle_airplane_mode']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/appium/device/start_activity']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_activity']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/appium/device/current_package']`
    - [ ] `[HttpMethod.httpGet, 'session/:session_id/appium/device/system_bars']`
    - [ ] `[HttpMethod.httpGet, 'session/:session_id/appium/device/display_density']`
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
    - [x] `[HttpMethod.httpGet, 'status']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/element/:id/displayed']`
    - ~~[ ] `[HtMethod.httpGet, 'session/:session_id/timeouts']`~~ <= already has
    - [x] `[HttpMethod.httpGet, 'session/:session_id']`
    - [ ] `[HttpMethod.httpGet, 'session/:session_id/orientation']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/orientation']`
    - [x] `[HtMethod.httpGet, 'session/:session_id/location']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/location']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/ime/available_engines']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/ime/active_engine']`
    - [x] `[HttpMethod.httpGet, 'session/:session_id/ime/activated']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/ime/deactivate']`
    - [x] `[HttpMethod.httpPost, 'session/:session_id/ime/activate']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/keys']`
    - [ ] `[HttpMethod.httpGet, 'session/:session_id/log/types']`
    - [ ] `[HttpMethod.httpPost, 'session/:session_id/log']`

