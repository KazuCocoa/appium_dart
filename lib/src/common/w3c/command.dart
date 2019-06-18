import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

// All available commands for Appium
class W3CCommands {
  static const commands = {
    'get_all_sessions': [
      HttpMethod.httpGet,
      'sessions'],
    'available_contexts': [
      HttpMethod.httpGet,
      'session/:session_id/contexts'],
    'set_context': [
      HttpMethod.httpPost,
      'session/:session_id/context'],
    'current_context': [
      HttpMethod.httpGet,
      'session/:session_id/context'],
    'touch_actions': [
      HttpMethod.httpPost,
      'session/:session_id/touch/perform'],
    'multi_touch': [
      HttpMethod.httpPost,
      'session/:session_id/touch/multi/perform'],
    'set_immediate_value': [
      HttpMethod.httpPost,
      'session/:session_id/appium/element/:id/value'],
    'replace_value': [
      HttpMethod.httpPost,
      'session/:session_id/appium/element/:id/replace_value'],
    'launch_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/launch'],
    'close_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/close'],
    'reset': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/reset'],
    'background_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/background'],
    'app_strings': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/strings'],

    'device_locked': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/is_locked'],
    'unlock': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/unlock'],
    'lock': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/lock'],
    'device_time': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/system_time'],
    'install_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/install_app'],
    'remove_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/remove_app'],
    'app_installed': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/app_installed'],
    'activate_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/activate_app'],
    'terminate_app': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/terminate_app'],
    'app_state': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/app_state'],
    'shake': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/shake'],
    'hide_keyboard': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/hide_keyboard'],
    'press_keycode': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/press_keycode'],
    'long_press_keycode': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/long_press_keycode'],
    'keyevent': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/keyevent'],
    'push_file': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/push_file'],
    'pull_file': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/pull_file'],
    'pull_folder': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/pull_folder'],
    'get_clipboard': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/get_clipboard'],
    'set_clipboard': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/set_clipboard'],
    'finger_print': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/finger_print'],
    'get_settings': [
      HttpMethod.httpGet,
      'session/:session_id/appium/settings'],
    'update_settings': [
      HttpMethod.httpPost,
      'session/:session_id/appium/settings'],
    'stop_recording_screen': [
      HttpMethod.httpPost,
      'session/:session_id/appium/stop_recording_screen'],
    'start_recording_screen': [
      HttpMethod.httpPost,
      'session/:session_id/appium/start_recording_screen'],
    'compare_images': [
      HttpMethod.httpPost,
      'session/:session_id/appium/compare_images'],
    'is_keyboard_shown': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/is_keyboard_shown'],

    // android
    'open_notifications': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/open_notifications'],
    'toggle_airplane_mode': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/toggle_airplane_mode'],
    'start_activity': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/start_activity'],
    'current_activity': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/current_activity'],
    'current_package': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/current_package'],
    'get_system_bars': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/system_bars'],
    'get_display_density': [
      HttpMethod.httpGet,
      'session/:session_id/appium/device/display_density'],
    'toggle_wifi': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/toggle_wifi'],
    'toggle_data': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/toggle_data'],
    'toggle_location_services': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/toggle_location_services'],
    'end_coverage': [
      HttpMethod.httpPost,
      'session/:session_id/appium/app/end_test_coverage'],
    'get_performance_data_types': [
      HttpMethod.httpPost,
      'session/:session_id/appium/performanceData/types'],
    'get_performance_data': [
      HttpMethod.httpPost,
      'session/:session_id/appium/getPerformanceData'],
    'get_network_connection': [
      HttpMethod.httpGet,
      'session/:session_id/network_connection'], // defined also in OSS
    'set_network_connection': [
      HttpMethod.httpPost,
      'session/:session_id/network_connection'], // defined also in OSS
    // only emulator
    'send_sms': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/send_sms'],
    'gsm_call': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/gsm_call'],
    'gsm_signal': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/gsm_signal'],
    'gsm_voice': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/gsm_voice'],
    'set_network_speed': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/network_speed'],
    'set_power_capacity': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/power_capacity'],
    'set_power_ac': [
      HttpMethod.httpPost,
      'session/:session_id/appium/device/power_ac'],

    //ios
    'touch_id': [
      HttpMethod.httpPost,
      'session/:session_id/appium/simulator/touch_id'],
    'toggle_touch_id_enrollment': [
      HttpMethod.httpPost,
      'session/:session_id/appium/simulator/toggle_touch_id_enrollment'],
  };
}


