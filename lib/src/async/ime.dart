import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class IME {
  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  IME(this._client, this._handler);

  Future<List<String>> getAvailableEngines() => _client.send(
      _handler.ime.buildGetAvailableEnginesRequest(),
      _handler.ime.parseGetAvailableEnginesResponse);

  Future<String> getActiveEngine() => _client.send(
      _handler.ime.buildGetActiveEngineRequest(),
      _handler.ime.parseGetActiveEngineResponse);

  Future<bool> isActivated() => _client.send(
      _handler.ime.buildIsActivatedRequest(),
      _handler.ime.parseIsActivatedResponse);

  Future<void> deactivate() => _client.send(
      _handler.ime.buildDeactivateRequest(),
      _handler.ime.parseDeactivateResponse);

  Future<void> activateEngine(String imeName) => _client.send(
      _handler.ime.buildActiveEngineRequest(imeName),
      _handler.ime.parseActiveEngineResponse);

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is IME &&
      other._client == _client &&
      other._handler == _handler;

  @override
  String toString() => '$_handler.appManagemenet($_client)';
}
