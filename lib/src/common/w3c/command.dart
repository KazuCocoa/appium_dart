import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

class Command {
  final HttpMethod method;
  final String path;

  const Command(this.method, this.path);
}

// All available commands for Appium
class W3CCommands {
  static const GET_ALL_SESSIONS = Command(HttpMethod.httpGet,
      'session'); // FIXME. The session command has no session_id
  static const AVAILABLE_CONTEXTS = Command(HttpMethod.httpGet, 'contexts');
  static const SET_CONTEXT = Command(HttpMethod.httpPost, 'context');
  static const CURRENT_CONTEXT = Command(HttpMethod.httpGet, 'context');
  static const TOUCH_ACTIONS = Command(HttpMethod.httpPost, 'touch/perform');
  static const MULTI_TOUCH =
      Command(HttpMethod.httpPost, 'touch/multi/perform');
  static const SET_IMMEDIATE_VALUE =
      Command(HttpMethod.httpPost, 'appium/element/:id/value');
  static const REPLACE_VALUE =
      Command(HttpMethod.httpPost, 'appium/element/:id/replace_value');
  static const LAUNCH_APP = Command(HttpMethod.httpPost, 'appium/app/launch');
  static const CLOSE_APP = Command(HttpMethod.httpPost, 'appium/app/close');
  static const RESET = Command(HttpMethod.httpPost, 'appium/app/reset');
  static const BACKGROUND_APP =
      Command(HttpMethod.httpPost, 'appium/app/background');
  static const APP_STRINGS = Command(HttpMethod.httpPost, 'appium/app/strings');
  static const DEVICE_LOCKED =
      Command(HttpMethod.httpPost, 'appium/device/is_locked');
  static const UNLOCK = Command(HttpMethod.httpPost, 'appium/device/unlock');
  static const LOCK = Command(HttpMethod.httpPost, 'appium/device/lock');
  static const DEVICE_TIME =
      Command(HttpMethod.httpGet, 'appium/device/system_time');
  static const INSTALL_APP =
      Command(HttpMethod.httpPost, 'appium/device/install_app');
  static const REMOVE_APP =
      Command(HttpMethod.httpPost, 'appium/device/remove_app');
  static const APP_INSTALLED =
      Command(HttpMethod.httpPost, 'appium/device/app_installed');
  static const ACTIVATE_APP =
      Command(HttpMethod.httpPost, 'appium/device/activate_app');
  static const TERMINATE_APP =
      Command(HttpMethod.httpPost, 'appium/device/terminate_app');
  static const APP_STATE =
      Command(HttpMethod.httpPost, 'appium/device/app_state');
  static const SHAKE = Command(HttpMethod.httpPost, 'appium/device/shake');
  static const HIDE_KEYBOARD =
      Command(HttpMethod.httpPost, 'appium/device/hide_keyboard');
  static const PRESS_KEYCODE =
      Command(HttpMethod.httpPost, 'appium/device/press_keycode');
  static const LONG_PRESS_KEYCODE =
      Command(HttpMethod.httpPost, 'appium/device/long_press_keycode');
  static const KEYEVENT =
      Command(HttpMethod.httpPost, 'appium/device/keyevent');
  static const PUSH_FILE =
      Command(HttpMethod.httpPost, 'appium/device/push_file');
  static const PULL_FILE =
      Command(HttpMethod.httpPost, 'appium/device/pull_file');
  static const PULL_FOLDER =
      Command(HttpMethod.httpPost, 'appium/device/pull_folder');
  static const GET_CLIPBOARD =
      Command(HttpMethod.httpPost, 'appium/device/get_clipboard');
  static const SET_CLIPBOARD =
      Command(HttpMethod.httpPost, 'appium/device/set_clipboard');
  static const FINGER_PRINT =
      Command(HttpMethod.httpPost, 'appium/device/finger_print');
  static const GET_SETTINGS = Command(HttpMethod.httpGet, 'appium/settings');
  static const UPDATE_SETTINGS =
      Command(HttpMethod.httpPost, 'appium/settings');
  static const STOP_RECORDING_SCREEN =
      Command(HttpMethod.httpPost, 'appium/stop_recording_screen');
  static const START_RECORDING_SCREEN =
      Command(HttpMethod.httpPost, 'appium/start_recording_screen');
  static const COMPARE_IMAGES =
      Command(HttpMethod.httpPost, 'appium/compare_images');
  static const IS_KEYBOARD_SHOWN =
      Command(HttpMethod.httpGet, 'appium/device/is_keyboard_shown');
  static const OPEN_NOTIFICATIONS =
      Command(HttpMethod.httpPost, 'appium/device/open_notifications');
  static const TOGGLE_AIRPLANE_MODE =
      Command(HttpMethod.httpPost, 'appium/device/toggle_airplane_mode');
  static const START_ACTIVITY =
      Command(HttpMethod.httpPost, 'appium/device/start_activity');
  static const CURRENT_ACTIVITY =
      Command(HttpMethod.httpGet, 'appium/device/current_activity');
  static const CURRENT_PACKAGE =
      Command(HttpMethod.httpGet, 'appium/device/current_package');
  static const GET_SYSTEM_BARS =
      Command(HttpMethod.httpGet, 'appium/device/system_bars');
  static const GET_DISPLAY_DENSITY =
      Command(HttpMethod.httpGet, 'appium/device/display_density');
  static const TOGGLE_WIFI =
      Command(HttpMethod.httpPost, 'appium/device/toggle_wifi');
  static const TOGGLE_DATA =
      Command(HttpMethod.httpPost, 'appium/device/toggle_data');
  static const TOGGLE_LOCATION_SERVICES =
      Command(HttpMethod.httpPost, 'appium/device/toggle_location_services');
  static const END_COVERAGE =
      Command(HttpMethod.httpPost, 'appium/app/end_test_coverage');
  static const GET_PERFORMANCE_DATA_TYPES =
      Command(HttpMethod.httpPost, 'appium/performanceData/types');
  static const GET_PERFORMANCE_DATA =
      Command(HttpMethod.httpPost, 'appium/getPerformanceData');
  static const GET_NETWORK_CONNECTION =
      Command(HttpMethod.httpGet, 'network_connection');
  static const SET_NETWORK_CONNECTION =
      Command(HttpMethod.httpPost, 'network_connection');
  static const SEND_SMS =
      Command(HttpMethod.httpPost, 'appium/device/send_sms');
  static const GSM_CALL =
      Command(HttpMethod.httpPost, 'appium/device/gsm_call');
  static const GSM_SIGNAL =
      Command(HttpMethod.httpPost, 'appium/device/gsm_signal');
  static const GSM_VOICE =
      Command(HttpMethod.httpPost, 'appium/device/gsm_voice');
  static const SET_NETWORK_SPEED =
      Command(HttpMethod.httpPost, 'appium/device/network_speed');
  static const SET_POWER_CAPACITY =
      Command(HttpMethod.httpPost, 'appium/device/power_capacity');
  static const SET_POWER_AC =
      Command(HttpMethod.httpPost, 'appium/device/power_ac');
  static const TOUCH_ID =
      Command(HttpMethod.httpPost, 'appium/simulator/touch_id');
  static const TOGGLE_TOUCH_ID_ENROLLMENT = Command(
      HttpMethod.httpPost, 'appium/simulator/toggle_touch_id_enrollment');
  static const STATUS = Command(HttpMethod.httpGet, 'status');
  static const IS_ELEMENT_DISPLAYED =
      Command(HttpMethod.httpGet, 'element/:id/displayed');
  static const GET_TIMEOUTS = Command(HttpMethod.httpGet, 'timeouts');
  static const GET_CAPABILITIES = Command(HttpMethod.httpGet, '');
  static const GET_SCREEN_ORIENTATION =
      Command(HttpMethod.httpGet, 'orientation');
  static const SET_SCREEN_ORIENTATION =
      Command(HttpMethod.httpPost, 'orientation');
  static const GET_LOCATION = Command(HttpMethod.httpGet, 'location');
  static const SET_LOCATION = Command(HttpMethod.httpPost, 'location');
  static const IME_GET_AVAILABLE_ENGINES =
      Command(HttpMethod.httpGet, 'ime/available_engines');
  static const IME_GET_ACTIVE_ENGINE =
      Command(HttpMethod.httpGet, 'ime/active_engine');
  static const IME_IS_ACTIVATED = Command(HttpMethod.httpGet, 'ime/activated');
  static const IME_DEACTIVATE = Command(HttpMethod.httpPost, 'ime/deactivate');
  static const IME_ACTIVATE_ENGINE =
      Command(HttpMethod.httpPost, 'ime/activate');
  static const SEND_KEYS_TO_ACTIVE_ELEMENT =
      Command(HttpMethod.httpPost, 'keys');
  static const GET_AVAILABLE_LOG_TYPES =
      Command(HttpMethod.httpGet, 'log/types');
  static const GET_LOG = Command(HttpMethod.httpPost, 'log');
}
