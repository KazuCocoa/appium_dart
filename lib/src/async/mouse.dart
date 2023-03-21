import 'dart:async';

import 'package:appium_driver/src/async/web_element.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/mouse.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Mouse {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Mouse(this._client, this._handler);

  /// Click any mouse button (at the coordinates set by the last moveTo).
  Future<void> click([MouseButton button = MouseButton.primary]) =>
      _client.send(_handler.mouse.buildClickRequest(button),
          _handler.mouse.parseClickResponse);

  /// Click and hold any mouse button (at the coordinates set by the last
  /// moveTo command).
  Future<void> down([MouseButton button = MouseButton.primary]) => _client.send(
      _handler.mouse.buildDownRequest(button),
      _handler.mouse.parseDownResponse);

  /// Releases the mouse button previously held (where the mouse is currently at).
  Future<void> up([MouseButton button = MouseButton.primary]) => _client.send(
      _handler.mouse.buildUpRequest(button), _handler.mouse.parseUpResponse);

  /// Double-clicks at the current mouse coordinates (set by moveTo).
  Future<void> doubleClick() => _client.send(
      _handler.mouse.buildDoubleClickRequest(),
      _handler.mouse.parseDoubleClickResponse);

  /// Move the mouse.
  ///
  /// If [element] is specified and [xOffset] and [yOffset] are not, will move
  /// the mouse to the centre of the [element].
  ///
  /// If [xOffset] and [yOffset] are specified, will move the mouse that distance
  /// from its current location.
  ///
  /// If all three are specified, will move the mouse to the offset relative to
  /// the top-left corner of the [element].
  ///
  /// All other combinations of parameters are illegal.
  ///
  /// Special notes for W3C, if the destination is out of the current viewport,
  /// an 'MoveTargetOutOfBounds' exception will be thrown.
  Future<void> moveTo(
          {AppiumWebElement? element,
          int? xOffset,
          int? yOffset,
          bool absolute = false}) =>
      _client.send(
          _handler.mouse.buildMoveToRequest(
              elementId: element?.id,
              xOffset: xOffset,
              yOffset: yOffset,
              absolute: absolute),
          _handler.mouse.parseMoveToResponse);

  /// Drag the mouse.
  /// From [xStart] and [yStart] coordinates
  /// To [xEnd] and [yEnd] coordinates
  /// e.g. await driver.mouse.dragFromTo(xStart: 0, yStart: 0, xEnd: 0, yEnd: 800);
  Future<void> dragFromTo(
      {int? xStart,
        int? yStart,
        int? xEnd,
        int? yEnd,
        bool absolute = false}) =>
      _client.send(
          _handler.mouse.buildDragFromToRequest(
              xStart: xStart,
              yStart: yStart,
              xEnd: xEnd,
              yEnd: yEnd,
              absolute: absolute),
          _handler.mouse.parseDragFromToResponse);

  @override
  String toString() => '$_handler.mouse($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Mouse && _handler == other._handler && _client == other._client;
}
