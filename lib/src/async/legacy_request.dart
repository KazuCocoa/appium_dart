import 'package:webdriver/src/common/exception.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

/// Retry a renamed endpoint only when the server does not recognize it.
/// Authentication, permission, session and other server errors are preserved.
Future<T> sendWithLegacyFallback<T>(
    AsyncRequestClient client,
    WebDriverRequest request,
    WebDriverRequest legacyRequest,
    T Function(WebDriverResponse) parse) async {
  try {
    return await client.send(request, parse);
  } on UnknownCommandException {
    return client.send(legacyRequest, parse);
  } on UnknownMethodException {
    return client.send(legacyRequest, parse);
  }
}
