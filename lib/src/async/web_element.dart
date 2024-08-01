import 'dart:async';
import 'dart:math';

import 'package:appium_driver/src/common/search_context.dart';
import 'package:appium_driver/src/common/by.dart';
import 'package:appium_driver/src/async/web_driver.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';

import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/web_element.dart' // ignore: implementation_imports
    as common; // ignore: implementation_imports

class AppiumWebElement extends common.WebElement
    implements AppiumSearchContext {
  @override
  final AppiumWebDriver driver;

  @override
  final String id;

  /// The context from which this element was found.
  final AppiumSearchContext? context;

  /// How the element was located from the context.
  final dynamic /* String | Finder */ locator;

  /// The index of this element in the set of element founds. If the method
  /// used to find this element always returns one element, then this is null.
  final int? index;

  final AsyncRequestClient _client;

  final AppiumWebDriverHandler _handler;

  AppiumWebElement(this.driver, this._client, this._handler, this.id,
      [this.context, this.locator, this.index]);

  /// Click on this element.
  Future<void> click() => _client.send(_handler.element.buildClickRequest(id),
      _handler.element.parseClickResponse);

  /// Send [keysToSend] to this element.
  Future<void> sendKeys(String keysToSend) => _client.send(
      _handler.element.buildSendKeysRequest(id, keysToSend),
      _handler.element.parseSendKeysResponse);

  /// Clear the content of a text element.
  Future<void> clear() => _client.send(_handler.element.buildClearRequest(id),
      _handler.element.parseClearResponse);

  /// Is this radio button/checkbox selected?
  Future<bool> get selected => _client.send(
      _handler.element.buildSelectedRequest(id),
      _handler.element.parseSelectedResponse);

  /// Is this form element enabled?
  Future<bool> get enabled => _client.send(
      _handler.element.buildEnabledRequest(id),
      _handler.element.parseEnabledResponse);

  /// Is this element visible in the page?
  Future<bool> get displayed => _client.send(
      _handler.element.buildDisplayedRequest(id),
      _handler.element.parseDisplayedResponse);

  /// The location within the document of this element.
  Future<Point> get location => _client.send(
      _handler.element.buildLocationRequest(id),
      _handler.element.parseLocationResponse);

  /// The size of this element.
  Future<Rectangle<int>> get size => _client.send(
      _handler.element.buildSizeRequest(id),
      _handler.element.parseSizeResponse);

  /// The tag name for this element.
  Future<String> get name => _client.send(_handler.element.buildNameRequest(id),
      _handler.element.parseNameResponse);

  ///  Visible text within this element.
  Future<String> get text => _client.send(_handler.element.buildTextRequest(id),
      _handler.element.parseTextResponse);

  ///Find an element nested within this element.
  ///
  /// Throws [NoSuchElementException] if matching element is not found.
  @override
  Future<AppiumWebElement> findElement(AppiumBy by) => _client.send(
      _handler.elementFinder.buildFindElementRequest(by, id),
      (response) => driver.getElement(
          _handler.elementFinder.parseFindElementResponse(response), this, by));

  /// Find multiple elements nested within this element.
  @override
  Stream<AppiumWebElement> findElements(AppiumBy by) async* {
    final ids = await _client.send(
        _handler.elementFinder.buildFindElementsRequest(by, id),
        _handler.elementFinder.parseFindElementsResponse);

    var i = 0;
    for (var id in ids) {
      yield driver.getElement(id, this, by, i);
      i++;
    }
  }

  /// Access to the HTML attributes of this tag.
  ///
  /// TODO(DrMarcII): consider special handling of boolean attributes.
  Attributes get attributes => Attributes((name) => _client.send(
      _handler.element.buildAttributeRequest(id, name),
      _handler.element.parseAttributeResponse));

  /// Access to the selenium attributes of this tag.
  ///
  /// This is deprecated, only used to support old pageloader.
  @deprecated
  Attributes get seleniumAttributes => Attributes((name) => _client.send(
      _handler.element.buildSeleniumAttributeRequest(id, name),
      _handler.element.parseSeleniumAttributeResponse));

  /// Access to the HTML properties of this tag.
  Attributes get properties => Attributes((name) => _client.send(
      _handler.element.buildPropertyRequest(id, name),
      _handler.element.parsePropertyResponse));

  /// Access to the cssProperties of this element.
  ///
  /// TODO(DrMarcII): consider special handling of colour and possibly other
  /// properties.
  Attributes get cssProperties => Attributes((name) => _client.send(
      _handler.element.buildCssPropertyRequest(id, name),
      _handler.element.parseCssPropertyResponse));

  Future<bool> equals(AppiumWebElement other) async =>
      // ignore: unnecessary_type_check
      other is AppiumWebElement && other.driver == driver && other.id == id;

  @override
  int get hashCode => driver.hashCode * 3 + id.hashCode;

  @override
  bool operator ==(other) =>
      other is AppiumWebElement && other.driver == driver && other.id == id;

  @override
  String toString() {
    var out = StringBuffer()..write(context);
    if (locator is AppiumBy) {
      if (index == null) {
        out.write('.findElement(');
      } else {
        out.write('.findElements(');
      }
      out
        ..write(locator)
        ..write(')');
    } else {
      out
        ..write('.')
        ..write(locator);
    }
    if (index != null) {
      out
        ..write('[')
        ..write(index)
        ..write(']');
    }
    return out.toString();
  }
}
