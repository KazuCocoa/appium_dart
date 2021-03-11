import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/cookie.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Cookies {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Cookies(this._client, this._handler);

  /// Sets a cookie.
  Future<void> add(Cookie cookie) => _client.send(
      _handler.cookies.buildAddCookieRequest(cookie),
      _handler.cookies.parseAddCookieResponse);

  /// Deletes the cookie with the given [name].
  Future<void> delete(String name) => _client.send(
      _handler.cookies.buildDeleteCookieRequest(name),
      _handler.cookies.parseDeleteCookieResponse);

  /// Deletes all cookies visible to the current page.
  Future<void> deleteAll() => _client.send(
      _handler.cookies.buildDeleteAllCookiesRequest(),
      _handler.cookies.parseDeleteAllCookiesResponse);

  /// Retrieve all cookies visible to the current page.
  Stream<Cookie> get all async* {
    final cookies = await _client.send(
        _handler.cookies.buildGetAllCookiesRequest(),
        _handler.cookies.parseGetAllCookiesResponse as List<Cookie> Function(WebDriverResponse));
    for (var cookie in cookies) {
      yield cookie;
    }
  }

  /// Retrieves cookie with the given name.
  Future<Cookie> getCookie(String name) => _client.send(
      _handler.cookies.buildGetCookieRequest(name),
      (response) => _handler.cookies.parseGetCookieResponse(response, name));

  @override
  String toString() => '$_handler.cookies($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Cookies &&
      _handler == other._handler &&
      _client == other._client;
}
