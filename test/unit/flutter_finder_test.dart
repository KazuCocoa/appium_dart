import 'dart:convert';

import 'package:appium_driver/src/common/flutter_finder.dart';
import 'package:test/test.dart';

void main() {
  group('flutter finders', () {
    test('byAncestor', () {
      expect(
          AppiumFlutterFinder.byAncestor(
              AppiumFlutterFinder.byAncestor(AppiumFlutterFinder.pageBack(),
                  AppiumFlutterFinder.pageBack(), matchingRoot: false),
              AppiumFlutterFinder.byAncestor(AppiumFlutterFinder.pageBack(),
                  AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matchingRoot: false),
          'eyJmaW5kZXJUeXBlIjoiQW5jZXN0b3IiLCJtYXRjaFJvb3QiOmZhbHNlLCJvZl9maW5kZXJUeXBlIjoiQW5jZXN0b3IiLCJvZl9tYXRjaFJvb3QiOmZhbHNlLCJvZl9vZl9maW5kZXJUeXBlIjoiUGFnZUJhY2siLCJvZl9tYXRjaGluZ19maW5kZXJUeXBlIjoiUGFnZUJhY2siLCJtYXRjaGluZ19maW5kZXJUeXBlIjoiQW5jZXN0b3IiLCJtYXRjaGluZ19tYXRjaFJvb3QiOmZhbHNlLCJtYXRjaGluZ19vZl9maW5kZXJUeXBlIjoiUGFnZUJhY2siLCJtYXRjaGluZ19tYXRjaGluZ19maW5kZXJUeXBlIjoiUGFnZUJhY2sifQ==');
    });

    test('byDescendant', () {
      expect(
          AppiumFlutterFinder.byDescendant(
              AppiumFlutterFinder.byDescendant(AppiumFlutterFinder.pageBack(),
                  AppiumFlutterFinder.pageBack(), matchingRoot: false),
              AppiumFlutterFinder.byDescendant(AppiumFlutterFinder.pageBack(),
                  AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matchingRoot: false),
          'eyJmaW5kZXJUeXBlIjoiRGVzY2VuZGFudCIsIm1hdGNoUm9vdCI6ZmFsc2UsIm9mX2ZpbmRlclR5cGUiOiJEZXNjZW5kYW50Iiwib2ZfbWF0Y2hSb290IjpmYWxzZSwib2Zfb2ZfZmluZGVyVHlwZSI6IlBhZ2VCYWNrIiwib2ZfbWF0Y2hpbmdfZmluZGVyVHlwZSI6IlBhZ2VCYWNrIiwibWF0Y2hpbmdfZmluZGVyVHlwZSI6IkRlc2NlbmRhbnQiLCJtYXRjaGluZ19tYXRjaFJvb3QiOmZhbHNlLCJtYXRjaGluZ19vZl9maW5kZXJUeXBlIjoiUGFnZUJhY2siLCJtYXRjaGluZ19tYXRjaGluZ19maW5kZXJUeXBlIjoiUGFnZUJhY2sifQ==');
    });

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
    expect(
        AppiumFlutterFinder.pageBack(), 'eyJmaW5kZXJUeXBlIjoiUGFnZUJhY2sifQ==');
  });

  test('byText', () {
    expect(AppiumFlutterFinder.byText('This is 2nd route'),
        'eyJmaW5kZXJUeXBlIjoiQnlUZXh0IiwidGV4dCI6IlRoaXMgaXMgMm5kIHJvdXRlIn0=');
  });
}
