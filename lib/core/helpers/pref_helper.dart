

import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

abstract class PrefHelper {
  static late SharedPreferences _prefs;
  static Future<void> load() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future<T> enumSetter<T extends Enum>(
    String key,
    T value,
    List<T> values, [
    bool presist = true,
  ]) async {
    if (presist) {
      await _prefs.setInt(key, value.index);
    }
    return values[_prefs.getInt(key) ?? value.index];
  }

  static Future<bool> boolSetter(
    String key,
    bool value, [
    bool presist = true,
  ]) async {
    if (presist) {
      await _prefs.setBool(key, value);
    }
    return _prefs.getBool(key) ?? value;
  }
}