# appium_dart

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

Take a look at (functional tests)[./test/functional]

# Lint

```
$ dartanalyzer --options analysis_options.yaml .
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
