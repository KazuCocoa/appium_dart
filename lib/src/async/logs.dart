import 'dart:async';

import 'package:appium_dart/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/log.dart';
import 'package:webdriver/src/common/request_client.dart';

class Logs {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Logs(this._client, this._handler);

  Stream<LogEntry> get(String logType) async* {
    try {
      final entries = await _client.send(
          _handler.logs.buildGetLogsRequest(logType),
          _handler.logs.parseGetLogsResponse);
      for (var entry in entries) {
        yield entry;
      }
    } on UnsupportedError {
      // Produces no entries for W3C/Firefox.
    }
  }

  @override
  String toString() => '$_handler.logs($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Logs && _handler == other._handler && _client == other._client;
}
