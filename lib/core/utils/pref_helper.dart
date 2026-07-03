import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class PrefHelper {
  late final SharedPreferences _prefs;
  Future<void> load() async => _prefs = await SharedPreferences.getInstance();
  Future<bool> clear() async => _prefs.clear();

  Future<T> enumSetter<T extends Enum>(
    String key,
    T value,
    List<T> values, [
    bool presist = true,
  ]) async {
    try {
      if (presist) {
        await _prefs.setInt(key, value.index);
      }
      return values[_prefs.getInt(key) ?? value.index];
    } catch (e) {
      return value;
    }
  }

  Future<bool> boolSetter(String key, bool value, [bool presist = true]) async {
    try {
      if (presist) {
        await _prefs.setBool(key, value);
      }
      return _prefs.getBool(key) ?? value;
    } catch (e) {
      return value;
    }
  }
}
