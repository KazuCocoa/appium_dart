import 'dart:convert';

class AppiumFlutterFinder {
  static String bySemanticsLabel(String label) {
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'BySemanticsLabel',
      'isRegExp': false,
      'label': label
    }).toString()));
  }

  static String bySemanticsLabelWithRegExp(String label) {
    print(label.toString());

    return base64.encode(utf8.encode(json.encode({
      'finderType': 'BySemanticsLabel',
      'isRegExp': true,
      'label': label
    }).toString()));
  }

  static String byTooltip(String text) {
    return base64.encode(utf8.encode(json
        .encode({'finderType': 'ByTooltipMessage', 'text': text}).toString()));
  }

  static String byType(String type) {
    return base64.encode(utf8.encode(
        json.encode({'finderType': 'ByType', 'type': type}).toString()));
  }

  static String byKeyValueInt(int key) {
    return base64.encode(utf8.encode(
        json.encode({
          'finderType': 'ByValueKey',
          'keyValueString': key,
          'keyValueType': 'int'
        }).toString()));
  }

  static String byKeyValueString(String key) {
    return base64.encode(utf8.encode(
        json.encode({
          'finderType': 'ByValueKey',
          'keyValueString': key,
          'keyValueType': 'String'
        }).toString()));
  }

  static String pageBack(String type) {
    return base64.encode(
        utf8.encode(json.encode({'finderType': 'PageBack'}).toString()));
  }

  static String byText(String text) {
    return base64.encode(utf8.encode(
        json.encode({'finderType': 'ByText', 'text': text}).toString()));
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
