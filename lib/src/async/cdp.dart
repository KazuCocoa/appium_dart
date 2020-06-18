import 'dart:async';
import 'dart:math';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class ChromeDevTools {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  ChromeDevTools(this._client, this._handler);

  /// Sets the window as active.
  Future<Map<String, dynamic>> execute(String cmd, Map<String, dynamic> params) => _client.send(
      _handler.cdp.buildExecuteRequest(cmd, params),
      _handler.cdp.parseExecuteResponse);

  @override
  int get hashCode =>  _client.hashCode;

  @override
  bool operator ==(other) =>
      other is ChromeDevTools &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.cdp($_client)';
}
