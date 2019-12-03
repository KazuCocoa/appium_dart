import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:appium_driver/src/common/log.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Logs {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Logs(this._client, this._handler);

  /// Handled as Stream
  ///
  /// Example:
  ///
  ///     var logs = driver.logs.get('logcat');
  ///     await logs.takes(1).toList()
  ///     //=> [ALL[2019-07-12 10:57:32.223Z]: 07-12 19:49:20.239 16290 16290 I AudioController: Created new AudioSource]
  ///
  Stream<AppiumLogEntry> get(String logType) async* {
    try {
      final entries = await _client.send(
          _handler.logs.buildGetLogsRequest(logType),
          _handler.logs.parseGetLogsResponse);
      for (var entry in entries) {
        yield entry;
      }
    } on UnsupportedError {
      // no entry
    }
  }

  Future<List<String>> getAvailableType() => _client.send(
      _handler.logs.buildGetAvailableTypeRequest(),
      _handler.logs.parseGetAvailableTypeResponse);

  /// Gets events
  ///
  /// Example:
  ///
  ///
  ///    await driver.logs.getEvents();
  ///    //=> {commands: [{cmd: timeouts, startTime: 1575388557299, endTime: 1575388557300}, {cmd: getLogTypes, startTime: 1575388557313, endTime: 1575388557313}, {cmd: getLog, startTime: 1575388557326, endTime: 1575388557326}, {cmd: logCustomEvent, startTime: 1575388557453, endTime: 1575388557454}, {cmd: getLogEvents, startTime: 1575388557458, endTime: 1575388557459}],
  ///    //    custom:event: [1575388557453]}
  ///
  Future<Map<String, dynamic>> getEvents({String type = ''}) => _client.send(
      _handler.logs.buildGetEventsRequest(type: type),
      _handler.logs.parseGetEventsResponse);

  /// Post a custom event
  ///
  /// Example:
  ///
  ///    await driver.logs.logEvent('custom', 'event');
  ///
  Future<void> logEvent(String vendor, String event) => _client.send(
      _handler.logs.buildLogEventRequest(vendor, event),
      _handler.logs.parseLogEventResponse);

  @override
  String toString() => '$_handler.logs($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Logs && _handler == other._handler && _client == other._client;
}
