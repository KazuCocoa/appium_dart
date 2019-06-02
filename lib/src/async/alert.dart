import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports


/// A JavaScript alert(), confirm(), or prompt() dialog
class Alert {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Alert(this._client, this._handler);

  /// The text of the JavaScript alert(), confirm(), or prompt() dialog.
  Future<String> get text => _client.send(_handler.alert.buildGetTextRequest(),
      _handler.alert.parseGetTextResponse);

  /// Accepts the currently displayed alert (may not be the alert for which this
  /// object was created).
  ///
  ///  Throws [NoSuchAlertException] if there isn't currently an alert.
  Future<void> accept() => _client.send(
      _handler.alert.buildAcceptRequest(), _handler.alert.parseAcceptResponse);

  /// Dismisses the currently displayed alert (may not be the alert for which
  /// this object was created).
  ///
  ///  Throws [NoSuchAlertException] if there isn't currently an alert.
  Future<void> dismiss() => _client.send(_handler.alert.buildDismissRequest(),
      _handler.alert.parseDismissResponse);

  /// Sends keys to the currently displayed alert (may not be the alert for
  /// which this object was created).
  ///
  /// Throws [NoSuchAlertException] if there isn't currently an alert
  Future<void> sendKeys(String keysToSend) => _client.send(
      _handler.alert.buildSendTextRequest(keysToSend),
      _handler.alert.parseSendTextResponse);

  @override
  String toString() => '$_handler.switchTo.alert($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Alert && _handler == other._handler && _client == other._client;
}
