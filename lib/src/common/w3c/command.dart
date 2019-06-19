import 'package:webdriver/src/common/request.dart'; // ignore: implementation_imports

class Command {
  final HttpMethod method;
  final String path;

  const Command(this.method, this.path);
}

// All available commands for Appium
class W3CCommands {
  static const commands = {
    'get_all_sessions': Command(HttpMethod.httpGet, 'sessions'),
    // FIXME. The session command has no session_id
    'available_contexts': Command(HttpMethod.httpGet, 'contexts'),
    'set_context': Command(HttpMethod.httpPost, 'context'),
    'current_context': Command(HttpMethod.httpGet, 'context'),
    'touch_actions': Command(HttpMethod.httpPost, 'touch/perform'),
    'multi_touch': Command(HttpMethod.httpPost, 'touch/multi/perform'),
    'set_immediate_value':
        Command(HttpMethod.httpPost, 'appium/element/:id/value'),
    'replace_value':
        Command(HttpMethod.httpPost, 'appium/element/:id/replace_value'),
    'launch_app': Command(HttpMethod.httpPost, 'appium/app/launch'),
    'close_app': Command(HttpMethod.httpPost, 'appium/app/close'),
    'reset': Command(HttpMethod.httpPost, 'appium/app/reset'),
    'background_app': Command(HttpMethod.httpPost, 'appium/app/background'),
    'app_strings': Command(HttpMethod.httpPost, 'appium/app/strings'),

    'device_locked': Command(HttpMethod.httpPost, 'appium/device/is_locked'),
    'unlock': Command(HttpMethod.httpPost, 'appium/device/unlock'),
    'lock': Command(HttpMethod.httpPost, 'appium/device/lock'),
    'device_time': Command(HttpMethod.httpGet, 'appium/device/system_time'),
    'install_app': Command(HttpMethod.httpPost, 'appium/device/install_app'),
    'remove_app': Command(HttpMethod.httpPost, 'appium/device/remove_app'),
    'app_installed':
        Command(HttpMethod.httpPost, 'appium/device/app_installed'),
    'activate_app': Command(HttpMethod.httpPost, 'appium/device/activate_app'),
    'terminate_app':
        Command(HttpMethod.httpPost, 'appium/device/terminate_app'),
    'app_state': Command(HttpMethod.httpPost, 'appium/device/app_state'),
    'shake': Command(HttpMethod.httpPost, 'appium/device/shake'),
    'hide_keyboard':
        Command(HttpMethod.httpPost, 'appium/device/hide_keyboard'),
    'press_keycode':
        Command(HttpMethod.httpPost, 'appium/device/press_keycode'),
    'long_press_keycode':
        Command(HttpMethod.httpPost, 'appium/device/long_press_keycode'),
    'keyevent': Command(HttpMethod.httpPost, 'appium/device/keyevent'),
    'push_file': Command(HttpMethod.httpPost, 'appium/device/push_file'),
    'pull_file': Command(HttpMethod.httpPost, 'appium/device/pull_file'),
    'pull_folder': Command(HttpMethod.httpPost, 'appium/device/pull_folder'),
    'get_clipboard':
        Command(HttpMethod.httpPost, 'appium/device/get_clipboard'),
    'set_clipboard':
        Command(HttpMethod.httpPost, 'appium/device/set_clipboard'),
    'finger_print': Command(HttpMethod.httpPost, 'appium/device/finger_print'),
    'get_settings': Command(HttpMethod.httpGet, 'appium/settings'),
    'update_settings': Command(HttpMethod.httpPost, 'appium/settings'),
    'stop_recording_screen':
        Command(HttpMethod.httpPost, 'appium/stop_recording_screen'),
    'start_recording_screen':
        Command(HttpMethod.httpPost, 'appium/start_recording_screen'),
    'compare_images': Command(HttpMethod.httpPost, 'appium/compare_images'),
    'is_keyboard_shown':
        Command(HttpMethod.httpGet, 'appium/device/is_keyboard_shown'),

    // android
    'open_notifications':
        Command(HttpMethod.httpPost, 'appium/device/open_notifications'),
    'toggle_airplane_mode':
        Command(HttpMethod.httpPost, 'appium/device/toggle_airplane_mode'),
    'start_activity':
        Command(HttpMethod.httpPost, 'appium/device/start_activity'),
    'current_activity':
        Command(HttpMethod.httpGet, 'appium/device/current_activity'),
    'current_package':
        Command(HttpMethod.httpGet, 'appium/device/current_package'),
    'get_system_bars': Command(HttpMethod.httpGet, 'appium/device/system_bars'),
    'get_display_density':
        Command(HttpMethod.httpGet, 'appium/device/display_density'),
    'toggle_wifi': Command(HttpMethod.httpPost, 'appium/device/toggle_wifi'),
    'toggle_data': Command(HttpMethod.httpPost, 'appium/device/toggle_data'),
    'toggle_location_services':
        Command(HttpMethod.httpPost, 'appium/device/toggle_location_services'),
    'end_coverage':
        Command(HttpMethod.httpPost, 'appium/app/end_test_coverage'),
    'get_performance_data_types':
        Command(HttpMethod.httpPost, 'appium/performanceData/types'),
    'get_performance_data':
        Command(HttpMethod.httpPost, 'appium/getPerformanceData'),
    'get_network_connection': Command(HttpMethod.httpGet, 'network_connection'),
    // defined also in O),
    'set_network_connection':
        Command(HttpMethod.httpPost, 'network_connection'),
    // defined also in O),
    // only emulator
    'send_sms': Command(HttpMethod.httpPost, 'appium/device/send_sms'),
    'gsm_call': Command(HttpMethod.httpPost, 'appium/device/gsm_call'),
    'gsm_signal': Command(HttpMethod.httpPost, 'appium/device/gsm_signal'),
    'gsm_voice': Command(HttpMethod.httpPost, 'appium/device/gsm_voice'),
    'set_network_speed':
        Command(HttpMethod.httpPost, 'appium/device/network_speed'),
    'set_power_capacity':
        Command(HttpMethod.httpPost, 'appium/device/power_capacity'),
    'set_power_ac': Command(HttpMethod.httpPost, 'appium/device/power_ac'),

    //ios
    'touch_id': Command(HttpMethod.httpPost, 'appium/simulator/touch_id'),
    'toggle_touch_id_enrollment': Command(
        HttpMethod.httpPost, 'appium/simulator/toggle_touch_id_enrollment'),

    // MJSONWP protocol Appium support for W3C as well
    'status': // TODO: add full path? Will check
        Command(HttpMethod.httpGet, 'status'),
    'is_element_displayed':
        Command(HttpMethod.httpGet, 'element/:id/displayed'),
    'get_timeouts': Command(HttpMethod.httpGet, 'timeouts'),
    // Session capability
    'get_capabilities': // TODO: add full path? Will check
        Command(HttpMethod.httpGet, 'session/:session_id'),
    'get_screen_orientation': Command(HttpMethod.httpGet, 'orientation'),
    'set_screen_orientation': Command(HttpMethod.httpPost, 'orientation'),
    'get_location': Command(HttpMethod.httpGet, 'location'),
    'set_location': Command(HttpMethod.httpPost, 'location'),
    // For IME
    'ime_get_available_engines':
        Command(HttpMethod.httpGet, 'ime/available_engines'),
    'ime_get_active_engine': Command(HttpMethod.httpGet, 'ime/active_engine'),
    'ime_is_activated': Command(HttpMethod.httpGet, 'ime/activated'),
    'ime_deactivate': Command(HttpMethod.httpPost, 'ime/deactivate'),
    'ime_activate_engine': Command(HttpMethod.httpPost, 'ime/activate'),

    'send_keys_to_active_element': Command(HttpMethod.httpPost, 'keys'),

    // Logs
    'get_available_log_types': Command(HttpMethod.httpGet, 'log/types'),
    'get_log': Command(HttpMethod.httpPost, 'log'),
  };
}
