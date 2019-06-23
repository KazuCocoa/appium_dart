import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Contexts {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Contexts(this._client, this._handler);

  Future<List<String>> getAvailableContexts() => _client.send(
      _handler.contexts.buildGetAvailableContextsRequest(),
      _handler.contexts.parseGetAvailableContexts);

  Future<String> getCurrentContext() => _client.send(
      _handler.contexts.buildGetCurrentContextRequest(),
      _handler.contexts.parseGetCurrentContext);

  Future<void> setContext(String context) => _client.send(
      _handler.contexts.buildSetContextRequest(context),
      _handler.contexts.parseSetContextResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Contexts &&
      other._client == this._client && other._handler == this._handler;

  @override
  String toString() => '$_handler.getCapabilities($_client)';
}
