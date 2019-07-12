import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:appium_driver/src/common/log.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Logs {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Logs(this._client, this._handler);

  Future<List<AppiumLogEntry>> get(String logType) => _client.send(
      _handler.logs.buildGetLogsRequest(logType),
      _handler.logs.parseGetLogsResponse);

  Future<List<String>> getAvailableType() => _client.send(
      _handler.logs.buildGetAvailableTypeRequest(),
      _handler.logs.parseGetAvailableTypeResponse);

  @override
  String toString() => '$_handler.logs($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Logs && _handler == other._handler && _client == other._client;
}
