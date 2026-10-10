import 'dart:async';
import 'dart:convert';

import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports
import 'package:webdriver/src/common/request_client.dart'; // ignore: implementation_imports

WebDriverResponse response(Object? value) =>
    WebDriverResponse(200, 'OK', jsonEncode({'value': value}));

WebDriverResponse errorResponse(String error, {int status = 404}) =>
    WebDriverResponse(
        status,
        'Error',
        jsonEncode({
          'value': {'error': error, 'message': 'Test error'}
        }));

class RecordingClient extends AsyncRequestClient {
  final FutureOr<WebDriverResponse> Function(WebDriverRequest) respond;
  final List<WebDriverRequest> requests = [];
  final List<Uri> urls = [];
  int closeCount = 0;

  RecordingClient(super.prefix, this.respond);

  @override
  Future<WebDriverResponse> sendRaw(WebDriverRequest request) async {
    if (closeCount != 0) throw StateError('Client is closed');
    requests.add(request);
    urls.add(resolve(request.uri!));
    return respond(request);
  }

  @override
  void close() => closeCount++;
}
