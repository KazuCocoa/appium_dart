## [Unreleased]
- Add location methods: `driver.device.getLocation`, `driver.device.setLocation`

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
