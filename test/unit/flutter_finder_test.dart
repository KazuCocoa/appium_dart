import 'dart:convert';

import 'package:appium_driver/src/common/flutter_finder.dart';
import 'package:test/test.dart';

void main() {
  group('flutter finders', () {
    test('bySemanticsLabel', () {
      expect(AppiumFlutterFinder.bySemanticsLabel('simple'),
          'eyJmaW5kZXJUeXBlIjoiQnlTZW1hbnRpY3NMYWJlbCIsImlzUmVnRXhwIjpmYWxzZSwibGFiZWwiOiJzaW1wbGUifQ==');
    });

    test('bySemanticsLabelWithRegExp', () {
      expect(AppiumFlutterFinder.bySemanticsLabelWithRegExp(r'complicated'),
          'eyJmaW5kZXJUeXBlIjoiQnlTZW1hbnRpY3NMYWJlbCIsImlzUmVnRXhwIjp0cnVlLCJsYWJlbCI6ImNvbXBsaWNhdGVkIn0=');
    });
  });

  test('byTooltip', () {
    expect(AppiumFlutterFinder.byTooltip('myText'),
        'eyJmaW5kZXJUeXBlIjoiQnlUb29sdGlwTWVzc2FnZSIsInRleHQiOiJteVRleHQifQ==');
  });

  test('byType', () {
    expect(AppiumFlutterFinder.byType('myText'),
        'eyJmaW5kZXJUeXBlIjoiQnlUeXBlIiwidHlwZSI6Im15VGV4dCJ9');
  });

  test('byKeyValueInt', () {
    expect(AppiumFlutterFinder.byKeyValueInt(42),
        'eyJmaW5kZXJUeXBlIjoiQnlWYWx1ZUtleSIsImtleVZhbHVlU3RyaW5nIjo0Miwia2V5VmFsdWVUeXBlIjoiaW50In0=');
  });

  test('byKeyValueString', () {
    expect(AppiumFlutterFinder.byKeyValueString('42'),
        'eyJmaW5kZXJUeXBlIjoiQnlWYWx1ZUtleSIsImtleVZhbHVlU3RyaW5nIjoiNDIiLCJrZXlWYWx1ZVR5cGUiOiJTdHJpbmcifQ==');
  });

  test('pageBack', () {
    expect(AppiumFlutterFinder.pageBack('42'),
        'eyJmaW5kZXJUeXBlIjoiUGFnZUJhY2sifQ==');
  });

  test('byText', () {
    expect(AppiumFlutterFinder.byText('This is 2nd route'),
        'eyJmaW5kZXJUeXBlIjoiQnlUZXh0IiwidGV4dCI6IlRoaXMgaXMgMm5kIHJvdXRlIn0=');
  });
}

//   // static byAncestor(String serializedFinder, )
//   //
//   //
//   // def by_ancestor(serialized_finder:, matching:, match_root: false)
//   // by_ancestor_or_descendant(
//   // type: 'Ancestor',
//   // serialized_finder: serialized_finder,
//   // matching: matching,
//   // match_root: match_root
//   // )
//   // end
//   //
//   // def by_descendant(serialized_finder:, matching:, match_root: false)
//   // by_ancestor_or_descendant(
//   // type: 'Descendant',
//   // serialized_finder: serialized_finder,
//   // matching: matching,
//   // match_root: match_root
//   // )
//   // end
// }
