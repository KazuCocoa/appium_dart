import 'dart:async';
import 'dart:convert';

import 'package:appium_driver/src/common/by.dart';
import 'package:appium_driver/src/common/search_context.dart';
import 'package:appium_driver/src/async/web_element.dart';
import 'package:appium_driver/src/async/target_locator.dart';
import 'package:appium_driver/src/common/utils.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:appium_driver/src/async/cookies.dart';
import 'package:appium_driver/src/async/keyboard.dart';
import 'package:appium_driver/src/async/mouse.dart';
import 'package:appium_driver/src/async/logs.dart';
import 'package:appium_driver/src/async/timeouts.dart';
import 'package:appium_driver/src/async/window.dart';
import 'package:appium_driver/src/async/app_state.dart';
import 'package:appium_driver/src/async/contexts.dart';
import 'package:appium_driver/src/async/app_management.dart';
import 'package:appium_driver/src/async/ime.dart';
import 'package:appium_driver/src/async/device.dart';
import 'package:appium_driver/src/async/settings.dart';
import 'package:appium_driver/src/async/sessions.dart';
import 'package:appium_driver/src/async/session.dart';
import 'package:appium_driver/src/async/status.dart';

import 'package:webdriver/src/async/stepper.dart' // ignore: implementation_imports
    show
        Stepper; // ignore: implementation_imports
import 'package:webdriver/src/common/spec.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

class AppiumWebDriver implements AppiumSearchContext {
  final WebDriverSpec spec;
  final Map<String, dynamic> capabilities;
  final String id;
  final Uri uri;
  Stepper stepper;

  /// If true, WebDriver actions are recorded as [WebDriverCommandEvent]s.
  bool notifyListeners = true;

  final _commandListeners = <AsyncWebDriverListener>[];

  final AppiumWebDriverHandler _handler;

  final AsyncRequestClient _client;

  AppiumWebDriver(this.uri, this.id, this.capabilities, this._client, this.spec)
      : this._handler = getHandler(spec);

  /// Preferred method for registering listeners. Listeners are expected to
  /// return a Future. Use new Future.value() for synchronous listeners.
  void addEventListener(AsyncWebDriverListener listener) {
    _commandListeners.add(listener);
    _client.addEventListener(listener);
  }

  /// The current url.
  Future<String> get currentUrl => _client.send(
      _handler.core.buildCurrentUrlRequest(),
      _handler.core.parseCurrentUrlResponse);

  /// Navigates to the specified url
  Future<void> get(/* Uri | String */ url) => _client.send(
      _handler.navigation
          .buildNavigateToRequest((url is Uri) ? url.toString() : url),
      _handler.navigation.parseNavigateToResponse);

  ///  Navigates forwards in the browser history, if possible.
  Future<void> forward() => _client.send(
      _handler.navigation.buildForwardRequest(),
      _handler.navigation.parseForwardResponse);

  /// Navigates backwards in the browser history, if possible.
  Future<void> back() => _client.send(_handler.navigation.buildBackRequest(),
      _handler.navigation.parseBackResponse);

  /// Refreshes the current page.
  Future<void> refresh() => _client.send(
      _handler.navigation.buildRefreshRequest(),
      _handler.navigation.parseRefreshResponse);

  /// The title of the current page.
  Future<String> get title => _client.send(
      _handler.core.buildTitleRequest(), _handler.core.parseTitleResponse);

  /// Search for multiple elements within the entire current page.
  @override
  Stream<AppiumWebElement> findElements(AppiumBy by) async* {
    final ids = await _client.send(
        _handler.elementFinder.buildFindElementsRequest(by),
        _handler.elementFinder.parseFindElementsResponse);
    int i = 0;

    for (var id in ids) {
      yield getElement(id, this, by, i);
      i++;
    }
  }

  /// Search for an element within the entire current page.
  /// Throws [NoSuchElementException] if a matching element is not found.
  @override
  Future<AppiumWebElement> findElement(AppiumBy by) => _client.send(
      _handler.elementFinder.buildFindElementRequest(by),
      (response) => getElement(
          _handler.elementFinder.parseFindElementResponse(response), this, by));

  /// An artist's rendition of the current page's source.
  Future<String> get pageSource => _client.send(
      _handler.core.buildPageSourceRequest(),
      _handler.core.parsePageSourceResponse);

  /// Quits the browser.
  Future<void> quit({bool closeSession = true}) => closeSession
      ? _client.send(_handler.core.buildDeleteSessionRequest(),
          _handler.core.parseDeleteSessionResponse)
      : Future.value();

  /// Closes the current window.
  ///
  /// This is rather confusing and will be removed.
  /// Should replace all usages with [window.close()] or [quit()].
  @deprecated
  Future<void> close() async => (await window).close();

  /// Handles for all of the currently displayed tabs/windows.
  Stream<Window> get windows async* {
    final windows = await _client.send(
        _handler.window.buildGetWindowsRequest(),
        (response) => _handler.window
            .parseGetWindowsResponse(response)
            .map<Window>((w) => Window(_client, _handler, w)));
    for (final window in windows) {
      yield window;
    }
  }

  /// Handle for the active tab/window.
  Future<Window> get window => _client.send(
      _handler.window.buildGetActiveWindowRequest(),
      (response) => Window(_client, _handler,
          _handler.window.parseGetActiveWindowResponse(response)));

  /// The currently focused element, or the body element if no element has
  /// focus.
  Future<AppiumWebElement> get activeElement async {
    final id = await _client.send(
        _handler.elementFinder.buildFindActiveElementRequest(),
        _handler.elementFinder.parseFindActiveElementResponse);
    if (id != null) {
      return getElement(id, this, 'activeElement');
    }
    return null;
  }

  TargetLocator get switchTo =>
      TargetLocator(this, this._client, this._handler);

  Cookies get cookies => Cookies(_client, _handler);

  /// [logs.get(logType)] will give list of logs captured in browser.
  ///
  /// Note that for W3C/Firefox, this is not supported and will produce empty
  /// list of logs, as the spec for this in W3C is not agreed on and Firefox
  /// refuses to support non-spec features. See
  /// https://github.com/w3c/webdriver/issues/406.
  Logs get logs => Logs(_client, _handler);

  Timeouts get timeouts => Timeouts(_client, _handler);

  Keyboard get keyboard => Keyboard(this._client, this._handler);

  Mouse get mouse => Mouse(this._client, this._handler);

  AppManagement get app => AppManagement(this._client, this._handler);

  AppState get appState => AppState(this._client, this._handler);

  Contexts get contexts => Contexts(this._client, this._handler);

  IME get ime => IME(this._client, this._handler);

  Device get device => Device(this._client, this._handler);

  Settings get settings => Settings(this._client, this._handler);

  Session get session => Session(this._client, this._handler);

  Sessions get sessions => Sessions(this.uri, this._handler);

  Status get status => Status(this.uri, this._handler);

  /// Take a screenshot of the current page as PNG and return it as
  /// base64-encoded string.
  Future<String> captureScreenshotAsBase64() => _client.send(
      _handler.core.buildScreenshotRequest(),
      _handler.core.parseScreenshotResponse);

  /// Take a screenshot of the current page as PNG as list of uint8.
  Future<List<int>> captureScreenshotAsList() async {
    var base64Encoded = captureScreenshotAsBase64();
    return base64.decode(await base64Encoded);
  }

  /// Take a screenshot of the current page as PNG as stream of uint8.
  ///
  /// Don't use this method. Prefer [captureScreenshotAsBase64] or
  /// [captureScreenshotAsList]. Returning the data as Stream<int> can be very
  /// slow.
  @Deprecated('Use captureScreenshotAsBase64 or captureScreenshotAsList!')
  Stream<int> captureScreenshot() async* {
    yield* Stream.fromIterable(await captureScreenshotAsList());
  }

  /// Inject a snippet of JavaScript into the page for execution in the context
  /// of the currently selected frame. The executed script is assumed to be
  /// asynchronous and must signal that is done by invoking the provided
  /// callback, which is always provided as the final argument to the function.
  /// The value to this callback will be returned to the client.
  ///
  /// Asynchronous script commands may not span page loads. If an unload event
  /// is fired while waiting for a script result, an error will be thrown.
  ///
  /// The script argument defines the script to execute in the form of a
  /// function body. The function will be invoked with the provided args array
  /// and the values may be accessed via the arguments object in the order
  /// specified. The final argument will always be a callback function that must
  /// be invoked to signal that the script has finished.
  ///
  /// Arguments may be any JSON-able object. WebElements will be converted to
  /// the corresponding DOM element. Likewise, any DOM Elements in the script
  /// result will be converted to WebElements.
  Future<dynamic> executeAsync(String script, List args) => _client.send(
      _handler.core.buildExecuteAsyncRequest(script, args),
      (response) => _handler.core.parseExecuteAsyncResponse(
          response, (elementId) => getElement(elementId, this, 'javascript')));

  /// Inject a snippet of JavaScript into the page for execution in the context
  /// of the currently selected frame. The executed script is assumed to be
  /// synchronous and the result of evaluating the script is returned.
  ///
  /// The script argument defines the script to execute in the form of a
  /// function body. The value returned by that function will be returned to the
  /// client. The function will be invoked with the provided args array and the
  /// values may be accessed via the arguments object in the order specified.
  ///
  /// Arguments may be any JSON-able object. WebElements will be converted to
  /// the corresponding DOM element. Likewise, any DOM Elements in the script
  /// result will be converted to WebElements.
  Future<dynamic> execute(String script, List args) => _client.send(
      _handler.core.buildExecuteRequest(script, args),
      (response) => _handler.core.parseExecuteResponse(
          response, (elementId) => getElement(elementId, this, 'javascript')));

  Future<dynamic> postRequest(String command, [params]) => _client.send(
      _handler.buildGeneralRequest(HttpMethod.httpPost, command, params),
      (response) => _handler.parseGeneralResponse(
          response, (elementId) => getElement(elementId, this)));

  Future<dynamic> getRequest(String command) => _client.send(
      _handler.buildGeneralRequest(HttpMethod.httpGet, command),
      (response) => _handler.parseGeneralResponse(
          response, (elementId) => getElement(elementId, this)));

  Future<dynamic> deleteRequest(String command) => _client.send(
      _handler.buildGeneralRequest(HttpMethod.httpDelete, command),
      (response) => _handler.parseGeneralResponse(
          response, (elementId) => getElement(elementId, this)));

  AppiumWebElement getElement(String elementId, [context, locator, index]) =>
      AppiumWebElement(
          this, _client, _handler, elementId, context, locator, index);

  @override
  AppiumWebDriver get driver => this;

  @override
  String toString() => '$_handler.appium_webdriver($_client)';
}
