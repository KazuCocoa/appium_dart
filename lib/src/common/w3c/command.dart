import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

class Command {
  final HttpMethod method;
  final String path;

  const Command(this.method, this.path);
}

// All available commands for Appium
class W3CCommands {
  static const commands = {
    'get_all_sessions':
      Command(HttpMethod.httpGet, 'sessions'), // FIXME. The session command has no session_id
    'available_contexts':
      Command(HttpMethod.httpGet, 'contexts'),
    'set_context':
      Command(HttpMethod.httpPost, 'context'),
    'current_context':
      Command(HttpMethod.httpGet, 'context'),
    'touch_actions':
      Command(HttpMethod.httpPost, 'touch/perform'),
    'multi_touch': [
      HttpMethod.httpPost,
      'touch/multi/perform'],
    'set_immediate_value': [
      HttpMethod.httpPost,
      'appium/element/:id/value'],
    'replace_value': [
      HttpMethod.httpPost,
      'appium/element/:id/replace_value'],
    'launch_app': [
      HttpMethod.httpPost,
      'appium/app/launch'],
    'close_app': [
      HttpMethod.httpPost,
      'appium/app/close'],
    'reset': [
      HttpMethod.httpPost,
      'appium/app/reset'],
    'background_app': [
      HttpMethod.httpPost,
      'appium/app/background'],
    'app_strings': [
      HttpMethod.httpPost,
      'appium/app/strings'],

    'device_locked': [
      HttpMethod.httpPost,
      'appium/device/is_locked'],
    'unlock': [
      HttpMethod.httpPost,
      'appium/device/unlock'],
    'lock': [
      HttpMethod.httpPost,
      'appium/device/lock'],
    'device_time': [
      HttpMethod.httpGet,
      'appium/device/system_time'],
    'install_app': [
      HttpMethod.httpPost,
      'appium/device/install_app'],
    'remove_app': [
      HttpMethod.httpPost,
      'appium/device/remove_app'],
    'app_installed': [
      HttpMethod.httpPost,
      'appium/device/app_installed'],
    'activate_app': [
      HttpMethod.httpPost,
      'appium/device/activate_app'],
    'terminate_app':
      Command(HttpMethod.httpPost, 'appium/device/terminate_app'),
    'app_state':
      Command(HttpMethod.httpPost, 'appium/device/app_state'),
    'shake': [
      HttpMethod.httpPost,
      'appium/device/shake'],
    'hide_keyboard': [
      HttpMethod.httpPost,
      'appium/device/hide_keyboard'],
    'press_keycode': [
      HttpMethod.httpPost,
      'appium/device/press_keycode'],
    'long_press_keycode': [
      HttpMethod.httpPost,
      'appium/device/long_press_keycode'],
    'keyevent': [
      HttpMethod.httpPost,
      'appium/device/keyevent'],
    'push_file': [
      HttpMethod.httpPost,
      'appium/device/push_file'],
    'pull_file': [
      HttpMethod.httpPost,
      'appium/device/pull_file'],
    'pull_folder': [
      HttpMethod.httpPost,
      'appium/device/pull_folder'],
    'get_clipboard': [
      HttpMethod.httpPost,
      'appium/device/get_clipboard'],
    'set_clipboard': [
      HttpMethod.httpPost,
      'appium/device/set_clipboard'],
    'finger_print': [
      HttpMethod.httpPost,
      'appium/device/finger_print'],
    'get_settings': [
      HttpMethod.httpGet,
      'appium/settings'],
    'update_settings': [
      HttpMethod.httpPost,
      'appium/settings'],
    'stop_recording_screen': [
      HttpMethod.httpPost,
      'appium/stop_recording_screen'],
    'start_recording_screen': [
      HttpMethod.httpPost,
      'appium/start_recording_screen'],
    'compare_images': [
      HttpMethod.httpPost,
      'appium/compare_images'],
    'is_keyboard_shown': [
      HttpMethod.httpGet,
      'appium/device/is_keyboard_shown'],

    // android
    'open_notifications': [
      HttpMethod.httpPost,
      'appium/device/open_notifications'],
    'toggle_airplane_mode': [
      HttpMethod.httpPost,
      'appium/device/toggle_airplane_mode'],
    'start_activity': [
      HttpMethod.httpPost,
      'appium/device/start_activity'],
    'current_activity': [
      HttpMethod.httpGet,
      'appium/device/current_activity'],
    'current_package': [
      HttpMethod.httpGet,
      'appium/device/current_package'],
    'get_system_bars': [
      HttpMethod.httpGet,
      'appium/device/system_bars'],
    'get_display_density': [
      HttpMethod.httpGet,
      'appium/device/display_density'],
    'toggle_wifi': [
      HttpMethod.httpPost,
      'appium/device/toggle_wifi'],
    'toggle_data': [
      HttpMethod.httpPost,
      'appium/device/toggle_data'],
    'toggle_location_services': [
      HttpMethod.httpPost,
      'appium/device/toggle_location_services'],
    'end_coverage': [
      HttpMethod.httpPost,
      'appium/app/end_test_coverage'],
    'get_performance_data_types': [
      HttpMethod.httpPost,
      'appium/performanceData/types'],
    'get_performance_data': [
      HttpMethod.httpPost,
      'appium/getPerformanceData'],
    'get_network_connection': [
      HttpMethod.httpGet,
      'network_connection'], // defined also in OSS
    'set_network_connection': [
      HttpMethod.httpPost,
      'network_connection'], // defined also in OSS
    // only emulator
    'send_sms': [
      HttpMethod.httpPost,
      'appium/device/send_sms'],
    'gsm_call': [
      HttpMethod.httpPost,
      'appium/device/gsm_call'],
    'gsm_signal': [
      HttpMethod.httpPost,
      'appium/device/gsm_signal'],
    'gsm_voice': [
      HttpMethod.httpPost,
      'appium/device/gsm_voice'],
    'set_network_speed': [
      HttpMethod.httpPost,
      'appium/device/network_speed'],
    'set_power_capacity': [
      HttpMethod.httpPost,
      'appium/device/power_capacity'],
    'set_power_ac': [
      HttpMethod.httpPost,
      'appium/device/power_ac'],

    //ios
    'touch_id': [
      HttpMethod.httpPost,
      'appium/simulator/touch_id'],
    'toggle_touch_id_enrollment': [
      HttpMethod.httpPost,
      'appium/simulator/toggle_touch_id_enrollment'],

    // MJSONWP protocol Appium support for W3C as well
    'status': [ // TODO: add full path? Will check
      HttpMethod.httpGet,
      'status'],
    'is_element_displayed': [
      HttpMethod.httpGet,
      'element/:id/displayed'],
    'get_timeouts': [
      HttpMethod.httpGet,
      'timeouts'],
    // Session capability
    'get_capabilities': [ // TODO: add full path? Will check
      HttpMethod.httpGet,
      'session/:session_id'],
    'get_screen_orientation': [
      HttpMethod.httpGet,
      'orientation'],
    'set_screen_orientation': [
      HttpMethod.httpPost,
      'orientation'],
    'get_location': [
      HttpMethod.httpGet,
      'location'],
    'set_location': [
      HttpMethod.httpPost,
      'location'],
    // For IME
    'ime_get_available_engines': [
      HttpMethod.httpGet,
      'ime/available_engines'],
    'ime_get_active_engine': [
      HttpMethod.httpGet,
      'ime/active_engine'],
    'ime_is_activated': [
      HttpMethod.httpGet,
      'ime/activated'],
    'ime_deactivate': [
      HttpMethod.httpPost,
      'ime/deactivate'],
    'ime_activate_engine': [
      HttpMethod.httpPost,
      'ime/activate'],

    'send_keys_to_active_element': [
      HttpMethod.httpPost,
      'keys'],

    // Logs
    'get_available_log_types': [
      HttpMethod.httpGet,
      'log/types'],
    'get_log': [
      HttpMethod.httpPost,
      'log']
  };
}
