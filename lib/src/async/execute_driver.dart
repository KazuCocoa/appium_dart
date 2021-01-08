import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class ExecuteDriver {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  ExecuteDriver(this._client, this._handler);

  Future<Map<String, dynamic>> executeDriver(
          String script, String type, Duration timeoutMs) =>
      _client.send(_handler.executeDriver.buildExecuteDriverRequest(script, type, timeoutMs),
          _handler.executeDriver.parseExecuteDriverResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is ExecuteDriver &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler($_client)';
}
