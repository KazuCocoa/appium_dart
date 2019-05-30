import 'package:webdriver/src/common/by.dart';

class AppiumBy extends By {
  const AppiumBy(String using, String value) : super(using, value);

  /// Returns an element whose ID attribute matches the search value.
  const AppiumBy.id(String id) : this('id', id);

  /// Returns an element matching an XPath expression.
  const AppiumBy.xpath(String xpath) : this('xpath', xpath);

  /// Returns an anchor element whose visible text matches the search value.
  const AppiumBy.linkText(String linkText) : this('link text', linkText);

  /// Returns an anchor element whose visible text partially matches the search
  /// value.
  const AppiumBy.partialLinkText(String partialLinkText)
      : this('partial link text', partialLinkText);

  /// Returns an element whose NAME attribute matches the search value.
  const AppiumBy.name(String name) : this('name', name);

  /// Returns an element whose tag name matches the search value.
  const AppiumBy.tagName(String tagName) : this('tag name', tagName);

  /// Returns an element whose class name contains the search value; compound
  /// class names are not permitted
  const AppiumBy.className(String className) : this('class name', className);

  /// Returns an element matching a CSS selector.
  const AppiumBy.cssSelector(String cssSelector)
      : this('css selector', cssSelector);

  /// Returns an element matching a accessibility identifier.
  const AppiumBy.accessibilityId(String accessibilityId)
      : this('accessibility id', accessibilityId);

  // TODO: Base64?
  const AppiumBy.image(String image) : this('-image', image);

  const AppiumBy.custom(String custom) : this('-custom', custom);

  /// Returns an element matching a uiautomator.
  const AppiumBy.uiautomator(String uiautomator)
      : this('-android uiautomator', uiautomator);

  /// Returns an element matching a viewtag.
  const AppiumBy.viewtag(String viewtag) : this('-android viewtag', viewtag);

  /// Returns an element matching a datamatcher.
  const AppiumBy.datamatcher(String datamatcher)
      : this('-android datamatcher', datamatcher);

  /// Returns an element matching a predicate string.
  const AppiumBy.predicateString(String predicateString)
      : this('-ios predicate string', predicateString);

  /// Returns an element matching a class chain.
  const AppiumBy.classChain(String classChain)
      : this('-ios class chain', classChain);

  @override
  String toString() {
    var constructor = using;
    switch (using) {
      case 'link text':
        constructor = 'linkText';
        break;
      case 'partial link text':
        constructor = 'partialLinkText';
        break;
      case 'name':
        constructor = 'name';
        break;
      case 'tag name':
        constructor = 'tagName';
        break;
      case 'class name':
        constructor = 'className';
        break;
      case 'css selector':
        constructor = 'cssSelector';
        break;
      case 'accessibility id':
        constructor = 'accessibilityId';
        break;
      case '-image':
        constructor = 'image';
        break;
      case '-custom':
        constructor = 'custom';
        break;
      case '-android uiautomator':
        constructor = 'uiautomator';
        break;
      case '-android viewtag':
        constructor = 'viewtag';
        break;
      case '-android datamatcher':
        constructor = 'datamatcher';
        break;
      case '-ios predicate string':
        constructor = 'predicateString';
        break;
      case '-ios class chain':
        constructor = 'classChain';
        break;
    }
    return 'AppiumBy.$constructor($value)';
  }
}
