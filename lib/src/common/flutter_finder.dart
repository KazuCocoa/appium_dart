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
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'ByValueKey',
      'keyValueString': key,
      'keyValueType': 'int'
    }).toString()));
  }

  static String byKeyValueString(String key) {
    return base64.encode(utf8.encode(json.encode({
      'finderType': 'ByValueKey',
      'keyValueString': key,
      'keyValueType': 'String'
    }).toString()));
  }

  static String pageBack() {
    return base64.encode(
        utf8.encode(json.encode({'finderType': 'PageBack'}).toString()));
  }

  static String byText(String text) {
    return base64.encode(utf8.encode(
        json.encode({'finderType': 'ByText', 'text': text}).toString()));
  }

  static String byAncestor(String serializedFinder, String matching,
      {bool matchingRoot: false}) {
    return AppiumFlutterFinder._byAncestorOrDescendant(
        'Ancestor', serializedFinder, matching, matchingRoot);
  }

  static String byDescendant(String serializedFinder, String matching,
      {bool matchingRoot: false}) {
    return AppiumFlutterFinder._byAncestorOrDescendant(
        'Descendant', serializedFinder, matching, matchingRoot);
  }

  static String _byAncestorOrDescendant(String type, String serializedFinder,
      String matching, bool matchingRoot) {
    var param = {'finderType': type, 'matchRoot': matchingRoot};
    var finder = json.decode(utf8.decode(base64.decode(serializedFinder)));

    if (finder != null) {
      finder.forEach((key, value) {
        param['of_$key'] = value;
      });
    }

    var matchingValue = json.decode(utf8.decode(base64.decode(matching)));
    if (matchingValue != null) {
      matchingValue.forEach((key, value) {
        param['matching_$key'] = value;
      });
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
