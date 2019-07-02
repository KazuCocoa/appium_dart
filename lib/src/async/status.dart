import 'dart:async';

import 'package:appium_driver/async_io.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Status {
  AsyncRequestClient _client;
  AppiumWebDriverHandler _handler;

  Status(Uri baseUrl, AppiumWebDriverHandler handler) {
    this._client = AsyncIoRequestClient(baseUrl);
    this._handler = handler;
  }

  /// Get sessions
  ///
  /// @example
  ///   driver.sessions.get()
  ///   #=> {"build":{"version":"1.14.0-beta.2",
  ///   "git-sha":"8a690f5abde5cf1c74f1cd185f15f51b3f7c3920",
  ///   "built":"2019-06-25 16:21:45 -0700"}}
  Future<Map<String, dynamic>> get() => _client.send(
      _handler.status.buildGetRequest(), _handler.status.parseGetResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Status &&
      other._client == this._client &&
      other._handler == this._handler;

  @override
  String toString() => '$_handler.sessions($_client)';
}
