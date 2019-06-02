import 'dart:async';

import 'package:appium_driver/async_core.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class TargetLocator {
  final AppiumWebDriver _driver;
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  TargetLocator(this._driver, this._client, this._handler);

  /// Changes focus to another frame on the page.
  /// If [frame] is a:
  ///   [int]: select by its zero-based index
  ///   [WebElement]: select the frame for a previously found frame or iframe
  ///       element.
  ///   [String]: same as above, but only CSS id is provided. Note that this
  ///       is not element id or frame id.
  ///   not provided: selects the first frame on the page or the main document.
  ///
  ///   Throws [NoSuchFrameException] if the specified frame can't be found.
  Future<void> frame([/* int | WebElement | String */ frame]) async {
    if (frame == null || frame is int) {
      await _client.send(_handler.frame.buildSwitchByIdRequest(frame),
          _handler.frame.parseSwitchByIdResponse);
    } else if (frame is AppiumWebDriver) {
      await _client.send(_handler.frame.buildSwitchByElementRequest(frame.id),
          _handler.frame.parseSwitchByElementResponse);
    } else if (frame is String) {
      final frameId = (await _driver.findElement(AppiumBy.id(frame))).id;
      await _client.send(_handler.frame.buildSwitchByElementRequest(frameId),
          _handler.frame.parseSwitchByElementResponse);
    } else {
      throw 'Unsupported frame "$frame" with type ${frame.runtimeType}';
    }
  }

  /// Changes focus to the parent frame of the current one.
  Future<void> parentFrame() => _client.send(
      _handler.frame.buildSwitchToParentRequest(),
      _handler.frame.parseSwitchToParentResponse);

  /// Switches the focus of void commands for this driver to the window with the
  /// given name/handle.
  ///
  /// Throws [NoSuchWindowException] if the specified window can't be found.
  Future<void> window(Window window) => window.setAsActive();

  /// Switches to the currently active modal dialog for this particular driver
  /// instance.
  ///
  /// Throws [NoSuchAlertException] if there is not currently an alert.
  Alert get alert => Alert(_client, _handler);

  @override
  String toString() => '$_driver.switchTo';

  @override
  int get hashCode => _driver.hashCode;

  @override
  bool operator ==(other) => other is TargetLocator && other._driver == _driver;
}
