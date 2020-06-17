import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static void addBoolToSP(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBoolFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key);
    if (value == null) {
      value = false;
    }
    return value;
  }
}
