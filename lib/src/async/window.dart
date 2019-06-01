import 'dart:async';
import 'dart:math';

import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart';

class Window {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;
  final String id;

  Window(this._client, this._handler, this.id);

  /// Sets the window as active.
  Future<void> setAsActive() => _client.send(
      _handler.window.buildSetActiveRequest(id),
      _handler.window.parseSetActiveResponse);

  /// The location of the window.
  Future<Point<int>> get location => _client.send(
      _handler.window.buildLocationRequest(),
      _handler.window.parseLocationResponse);

  /// The outer size of the window.
  Future<Rectangle<int>> get size => _client.send(
      _handler.window.buildSizeRequest(), _handler.window.parseSizeResponse);

  /// The inner size of the window.
  Future<Rectangle<int>> get innerSize => _client.send(
      _handler.window.buildInnerSizeRequest(),
      _handler.window.parseInnerSizeResponse);

  /// The location and size of the window.
  Future<Rectangle<int>> get rect async {
    try {
      return await _client.send(_handler.window.buildRectRequest(),
          _handler.window.parseRectResponse);
    } on UnsupportedError {
      // JsonWire cannot implement this API in one call.
      // Delegate to other methods.
      final location = await this.location;
      final size = await this.size;
      return Rectangle<int>(location.x, location.y, size.width, size.height);
    }
  }

  /// Sets the window location.
  Future<void> setLocation(Point<int> point) => _client.send(
      _handler.window.buildSetLocationRequest(point),
      _handler.window.parseSetLocationResponse);

  /// Sets the window size.
  Future<void> setSize(Rectangle<int> size) => _client.send(
      _handler.window.buildSetSizeRequest(size),
      _handler.window.parseSetSizeResponse);

  /// The location and size of the window.
  Future<void> setRect(Rectangle<int> rect) async {
    try {
      await _client.send(_handler.window.buildSetRectRequest(rect),
          _handler.window.parseSetRectResponse);
      return;
    } on UnsupportedError {
      // JsonWire cannot implement this API in one call.
      // Delegate to other methods.
      await setLocation(rect.topLeft);
      await setSize(Rectangle(0, 0, rect.width, rect.height));
    }
  }

  /// Maximizes the window.
  Future<void> maximize() => _client.send(
      _handler.window.buildMaximizeRequest(),
      _handler.window.parseMaximizeResponse);

  /// Minimizes the window.
  ///
  /// Unsupported in JsonWire WebDriver.
  Future<void> minimize() => _client.send(
      _handler.window.buildMinimizeRequest(),
      _handler.window.parseMinimizeResponse);

  /// Closes the window.
  Future close() => _client.send(
      _handler.window.buildCloseRequest(), _handler.window.parseCloseResponse);

  @override
  int get hashCode => id.hashCode + _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Window &&
      other._client == this._client &&
      other._handler == this._handler &&
      other.id == this.id;

  @override
  String toString() => '$_handler.windows($_client)[$id]';
}
