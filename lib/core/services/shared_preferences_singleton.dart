import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static setBool(String key, bool value) => _preferences.setBool(key, value);

  static getBool(String key) => _preferences.getBool(key) ?? false;
}
