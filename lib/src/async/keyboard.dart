import 'dart:async';

import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class Keyboard {
  static const String nullChar = '\uE000';
  static const String cancel = '\uE001';
  static const String help = '\uE002';
  static const String backSpace = '\uE003';
  static const String tab = '\uE004';
  static const String clear = '\uE005';
  static const String returnChar = '\uE006';
  static const String enter = '\uE007';
  static const String shift = '\uE008';
  static const String control = '\uE009';
  static const String alt = '\uE00A';
  static const String pause = '\uE00B';
  static const String escape = '\uE00C';
  static const String space = '\uE00D';
  static const String pageUp = '\uE00E';
  static const String pageDown = '\uE00F';
  static const String end = '\uE010';
  static const String home = '\uE011';
  static const String left = '\uE012';
  static const String up = '\uE013';
  static const String right = '\uE014';
  static const String down = '\uE015';
  static const String insert = '\uE016';
  static const String delete = '\uE017';
  static const String semicolon = '\uE018';
  static const String equals = '\uE019';
  static const String numpad0 = '\uE01A';
  static const String numpad1 = '\uE01B';
  static const String numpad2 = '\uE01C';
  static const String numpad3 = '\uE01D';
  static const String numpad4 = '\uE01E';
  static const String numpad5 = '\uE01F';
  static const String numpad6 = '\uE020';
  static const String numpad7 = '\uE021';
  static const String numpad8 = '\uE022';
  static const String numpad9 = '\uE023';
  static const String multiply = '\uE024';
  static const String add = '\uE025';
  static const String separator = '\uE026';
  static const String subtract = '\uE027';
  static const String decimal = '\uE028';
  static const String divide = '\uE029';
  static const String f1 = '\uE031';
  static const String f2 = '\uE032';
  static const String f3 = '\uE033';
  static const String f4 = '\uE034';
  static const String f5 = '\uE035';
  static const String f6 = '\uE036';
  static const String f7 = '\uE037';
  static const String f8 = '\uE038';
  static const String f9 = '\uE039';
  static const String f10 = '\uE03A';
  static const String f11 = '\uE03B';
  static const String f12 = '\uE03C';
  static const String command = '\uE03D';
  static const String meta = command;

  final AsyncRequestClient _client;
  final AppiumWebDriverHandler _handler;

  Keyboard(this._client, this._handler);

  /// Simulate pressing many keys at once as a 'chord'.
  Future<void> sendChord(Iterable<String> chordToSend) => _client.send(
      _handler.keyboard.buildSendChordRequest(chordToSend),
      _handler.keyboard.parseSendChordResponse);

  /// Send [keysToSend] to the active element.
  Future<void> sendKeys(String keysToSend) => _client.send(
      _handler.keyboard.buildSendKeysRequest(keysToSend),
      _handler.keyboard.parseSendKeysResponse);

  /// Hide shown keyboard
  Future<void> hide() => _client.send(
      _handler.keyboard.buildHideKeyboardRequest(),
      _handler.keyboard.parseHideKeyboardResponse);

  /// Whether the keyboard is shown
  Future<bool> isShown() => _client.send(
      _handler.keyboard.buildIsKeyboardShownRequest(),
      _handler.keyboard.parseIsKeyboardShownResponse);

  @override
  String toString() => '$_handler.keyboard($_client)';

  @override
  int get hashCode => _client.hashCode;

  @override
  bool operator ==(other) =>
      other is Keyboard &&
      _handler == other._handler &&
      _client == other._client;
}
