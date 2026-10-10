import 'dart:async';

import 'package:appium_driver/async_io.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Status {
  final Uri _baseUrl;
  final AppiumWebDriverHandler _handler;
  final AsyncRequestClient Function(Uri) _createRequestClient;

  Status(this._baseUrl, this._handler,
      {AsyncRequestClient Function(Uri)? createRequestClient})
      : _createRequestClient = createRequestClient ?? AsyncIoRequestClient.new;

  /// Get sessions
  ///
  /// ```dart
  /// driver.sessions.get()
  /// //=> {"build":{"version":"1.14.0-beta.2",
  /// // "git-sha":"8a690f5abde5cf1c74f1cd185f15f51b3f7c3920",
  /// // "built":"2019-06-25 16:21:45 -0700"}}
  /// ```
  Future<Map<String, dynamic>> get() async {
    final client = _createRequestClient(_baseUrl);
    try {
      return await client.send(
          _handler.status.buildGetRequest(), _handler.status.parseGetResponse);
    } finally {
      client.close();
    }
  }

  @override
  int get hashCode => Object.hash(_baseUrl, _handler, _createRequestClient);

  @override
  bool operator ==(other) =>
      other is Status &&
      other._baseUrl == _baseUrl &&
      other._createRequestClient == _createRequestClient &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.sessions($_baseUrl)';
}
