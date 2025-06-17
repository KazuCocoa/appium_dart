import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:appium_driver/src/async/device.dart';
import 'package:appium_driver/src/common/webdriver_handler.dart';
import 'package:webdriver/src/common/request_client.dart';
import 'package:webdriver/src/common/request.dart';

class MockAsyncRequestClient extends Mock implements AsyncRequestClient {}
class MockAppiumWebDriverHandler extends Mock implements AppiumWebDriverHandler {}
class MockDeviceHandler extends Mock implements DeviceHandler {}

void main() {
  group('Device', () {
    late MockAsyncRequestClient client;
    late MockAppiumWebDriverHandler handler;
    late MockDeviceHandler deviceHandler;
    late Device device;

    setUp(() {
      client = MockAsyncRequestClient();
      handler = MockAppiumWebDriverHandler();
      deviceHandler = MockDeviceHandler();
      when(handler.device).thenReturn(deviceHandler);
      device = Device(client, handler);
    });

    test('isLocked sends correct request and parses response', () async {
      final request = WebDriverRequest('GET', 'mock/is_locked');
      when(deviceHandler.buildDeviceIsLockedRequest()).thenReturn(request);
      when(client.send(request, any)).thenAnswer((invocation) async {
        final parser = invocation.positionalArguments[1] as dynamic;
        return parser('mock_response');
      });
      when(deviceHandler.parseDeviceIsLockedResponse('mock_response')).thenReturn(true);

      final result = await device.isLocked();
      expect(result, isTrue);
      verify(deviceHandler.buildDeviceIsLockedRequest()).called(1);
      verify(client.send(request, any)).called(1);
      verify(deviceHandler.parseDeviceIsLockedResponse('mock_response')).called(1);
    });

    test('lock sends correct request and parses response', () async {
      final request = WebDriverRequest('POST', 'mock/lock');
      when(deviceHandler.buildLockDeviceRequest(seconds: anyNamed('seconds'))).thenReturn(request);
      when(client.send(request, any)).thenAnswer((invocation) async {
        final parser = invocation.positionalArguments[1] as dynamic;
        return parser('mock_response');
      });
      when(deviceHandler.parseLockDeviceResponse('mock_response')).thenReturn(null);

      await device.lock(seconds: const Duration(seconds: 2));
      verify(deviceHandler.buildLockDeviceRequest(seconds: const Duration(seconds: 2))).called(1);
      verify(client.send(request, any)).called(1);
      verify(deviceHandler.parseLockDeviceResponse('mock_response')).called(1);
    });

    test('unlock sends correct request and parses response', () async {
      final request = WebDriverRequest('POST', 'mock/unlock');
      when(deviceHandler.buildUnlockDeviceRequest()).thenReturn(request);
      when(client.send(request, any)).thenAnswer((invocation) async {
        final parser = invocation.positionalArguments[1] as dynamic;
        return parser('mock_response');
      });
      when(deviceHandler.parseUnlockDeviceResponse('mock_response')).thenReturn(null);

      await device.unlock();
      verify(deviceHandler.buildUnlockDeviceRequest()).called(1);
      verify(client.send(request, any)).called(1);
      verify(deviceHandler.parseUnlockDeviceResponse('mock_response')).called(1);
    });

    // ...repeat for all other Device methods...
  });
}
