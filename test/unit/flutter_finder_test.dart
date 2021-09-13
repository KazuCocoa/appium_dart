import 'package:appium_driver/src/common/flutter_finder.dart';
import 'package:test/test.dart';

void main() {
  group('flutter finders', () {
    test('byAncestor', () {
      expect(
          AppiumFlutterFinder.byAncestor(
              of: AppiumFlutterFinder.byAncestor(
                  of: AppiumFlutterFinder.pageBack(),
                  matching: AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matching: AppiumFlutterFinder.byAncestor(
                  of: AppiumFlutterFinder.pageBack(),
                  matching: AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matchingRoot: false,
              firstMatchOnly: true),
          'eyJmaW5kZXJUeXBlIjoiQW5jZXN0b3IiLCJtYXRjaFJvb3QiOmZhbHNlLCJmaXJzdE1hdGNoT25seSI6dHJ1ZSwib2YiOiJ7XCJmaW5kZXJUeXBlXCI6XCJBbmNlc3RvclwiLFwibWF0Y2hSb290XCI6ZmFsc2UsXCJmaXJzdE1hdGNoT25seVwiOmZhbHNlLFwib2ZcIjpcIntcXFwiZmluZGVyVHlwZVxcXCI6XFxcIlBhZ2VCYWNrXFxcIn1cIixcIm1hdGNoaW5nXCI6XCJ7XFxcImZpbmRlclR5cGVcXFwiOlxcXCJQYWdlQmFja1xcXCJ9XCJ9IiwibWF0Y2hpbmciOiJ7XCJmaW5kZXJUeXBlXCI6XCJBbmNlc3RvclwiLFwibWF0Y2hSb290XCI6ZmFsc2UsXCJmaXJzdE1hdGNoT25seVwiOmZhbHNlLFwib2ZcIjpcIntcXFwiZmluZGVyVHlwZVxcXCI6XFxcIlBhZ2VCYWNrXFxcIn1cIixcIm1hdGNoaW5nXCI6XCJ7XFxcImZpbmRlclR5cGVcXFwiOlxcXCJQYWdlQmFja1xcXCJ9XCJ9In0=');
    });

    test('byDescendant', () {
      expect(
          AppiumFlutterFinder.byDescendant(
              of: AppiumFlutterFinder.byDescendant(
                  of: AppiumFlutterFinder.pageBack(),
                  matching: AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matching: AppiumFlutterFinder.byDescendant(
                  of: AppiumFlutterFinder.pageBack(),
                  matching: AppiumFlutterFinder.pageBack(),
                  matchingRoot: false),
              matchingRoot: false),
          'eyJmaW5kZXJUeXBlIjoiRGVzY2VuZGFudCIsIm1hdGNoUm9vdCI6ZmFsc2UsImZpcnN0TWF0Y2hPbmx5IjpmYWxzZSwib2YiOiJ7XCJmaW5kZXJUeXBlXCI6XCJEZXNjZW5kYW50XCIsXCJtYXRjaFJvb3RcIjpmYWxzZSxcImZpcnN0TWF0Y2hPbmx5XCI6ZmFsc2UsXCJvZlwiOlwie1xcXCJmaW5kZXJUeXBlXFxcIjpcXFwiUGFnZUJhY2tcXFwifVwiLFwibWF0Y2hpbmdcIjpcIntcXFwiZmluZGVyVHlwZVxcXCI6XFxcIlBhZ2VCYWNrXFxcIn1cIn0iLCJtYXRjaGluZyI6IntcImZpbmRlclR5cGVcIjpcIkRlc2NlbmRhbnRcIixcIm1hdGNoUm9vdFwiOmZhbHNlLFwiZmlyc3RNYXRjaE9ubHlcIjpmYWxzZSxcIm9mXCI6XCJ7XFxcImZpbmRlclR5cGVcXFwiOlxcXCJQYWdlQmFja1xcXCJ9XCIsXCJtYXRjaGluZ1wiOlwie1xcXCJmaW5kZXJUeXBlXFxcIjpcXFwiUGFnZUJhY2tcXFwifVwifSJ9');
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
