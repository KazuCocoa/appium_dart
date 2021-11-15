import 'dart:convert';

class AppiumFlutterFinder {
  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [label].
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.bySemanticsLabel('simple')
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String bySemanticsLabel(String label) {
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'BySemanticsLabel',
      'isRegExp': false,
      'label': label
    }).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [label]. It should be Regex as string.
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  /// https://api.flutter.dev/flutter/dart-core/RegExp-class.html
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.bySemanticsLabelWithRegExp('(\w+)')
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String bySemanticsLabelWithRegExp(String label) {
    print(label.toString());

    return base64.encode(utf8.encode(json.encode({
      'finderType': 'BySemanticsLabel',
      'isRegExp': true,
      'label': label
    }).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [text].
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.byTooltip('sample')
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byTooltip(String text) {
    return base64.encode(utf8.encode(json
        .encode({'finderType': 'ByTooltipMessage', 'text': text}).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [type].
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.byTooltip('myText')
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byType(String type) {
    return base64.encode(utf8.encode(
        json.encode({'finderType': 'ByType', 'type': type}).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [key] as int.
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.key(42)
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byKeyValueInt(int key) {
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'ByValueKey',
      'keyValueString': key,
      'keyValueType': 'int'
    }).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [key] as string.
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.key('42')
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byKeyValueString(String key) {
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'ByValueKey',
      'keyValueString': key,
      'keyValueType': 'String'
    }).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver.
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.pageBack()
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String pageBack() {
    return base64.encode(
        utf8.encode(json.encode({'finderType': 'PageBack'}).toString()));
  }

  static String byText(String text) {
    return base64.encode(utf8.encode(
        json.encode({'finderType': 'ByText', 'text': text}).toString()));
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [of], [matching] and [matchingRoot].
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// Please read https://api.flutter.dev/flutter/flutter_driver/CommonFinders/ancestor.html
  /// for more details about each arguments.
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.byAncestor(
  ///                  of: AppiumFlutterFinder.byAncestor(
  ///                      of: AppiumFlutterFinder.pageBack(),
  ///                      matching: AppiumFlutterFinder.pageBack(),
  ///                      matchingRoot: false),
  ///                  matching: AppiumFlutterFinder.byAncestor(
  ///                      of: AppiumFlutterFinder.pageBack(),
  ///                      matching: AppiumFlutterFinder.pageBack(),
  ///                      matchingRoot: false),
  ///                  matchingRoot: false,
  ///                  firstMatchOnly: true)
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byAncestor(
      {required String of,
      required String matching,
      bool matchingRoot = false,
      bool firstMatchOnly = false}) {
    return AppiumFlutterFinder._byAncestorOrDescendant(
        'Ancestor', of, matching, matchingRoot, firstMatchOnly);
  }

  /// Returns base64 encoded string as a finder for appium-flutter-driver
  /// with the given [of], [matching] and [matchingRoot].
  /// https://github.com/truongsinh/appium-flutter-driver#finders
  ///
  /// Please read https://api.flutter.dev/flutter/flutter_driver/CommonFinders/descendant.html
  /// for more details about each arguments.
  ///
  /// ```dart
  /// var finder = AppiumFlutterFinder.byDescendant(
  ///                  of: AppiumFlutterFinder.byDescendant(
  ///                      of: AppiumFlutterFinder.pageBack(),
  ///                      matching: AppiumFlutterFinder.pageBack(),
  ///                      matchingRoot: false),
  ///                  matching: AppiumFlutterFinder.byDescendant(
  ///                      of: AppiumFlutterFinder.pageBack(),
  ///                      matching: AppiumFlutterFinder.pageBack(),
  ///                      matchingRoot: false),
  ///                  matchingRoot: false
  ///                  firstMatchOnly: false)
  /// var element = driver.getElement(finder);
  /// await element.click();  // Do actions against the element
  /// ```
  static String byDescendant(
      {required String of,
      required String matching,
      bool matchingRoot = false,
      bool firstMatchOnly = false}) {
    return AppiumFlutterFinder._byAncestorOrDescendant(
        'Descendant', of, matching, matchingRoot, firstMatchOnly);
  }

  static String _byAncestorOrDescendant(String type, String serializedFinder,
      String matching, bool matchingRoot, bool firstMatchOnly) {
    var param = {
      'finderType': type,
      'matchRoot': matchingRoot,
      'firstMatchOnly': firstMatchOnly
    };
    var finder = json.decode(utf8.decode(base64.decode(serializedFinder)));

    if (finder != null) {
      var ofParam = {};
      finder.forEach((key, value) {
        ofParam[key] = value;
      });
      param['of'] = json.encode(ofParam);
    }

    var matchingValue = json.decode(utf8.decode(base64.decode(matching)));
    if (matchingValue != null) {
      var matchingParam = {};
      matchingValue.forEach((key, value) {
        matchingParam[key] = value;
      });
      param['matching'] = json.encode(matchingParam);
    }

    return base64.encode(utf8.encode(json.encode(param).toString()));
  }

  // static byAncestor(String serializedFinder, )
  //
  //
  // def by_ancestor(serialized_finder:, matching:, match_root: false)
  // by_ancestor_or_descendant(
  // type: 'Ancestor',
  // serialized_finder: serialized_finder,
  // matching: matching,
  // match_root: match_root
  // )
  // end
  //
  // def by_descendant(serialized_finder:, matching:, match_root: false)
  // by_ancestor_or_descendant(
  // type: 'Descendant',
  // serialized_finder: serialized_finder,
  // matching: matching,
  // match_root: match_root
  // )
  // end
}
