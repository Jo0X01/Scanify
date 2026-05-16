import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const theme = 'theme';
  static const amoled = 'amoled';
  static const language = 'language';
  static const autoScan = 'autoScan';
  static const sound = 'sound';
  static const haptics = 'haptics';
  static const autoDelete = 'autoDelete';
}

class SettingsService {
  SettingsService._();
  static final SettingsService instance = SettingsService._();
  late SharedPreferences _prefs;

  final theme = ValueNotifier<String>('system');
  final amoled = ValueNotifier<bool>(false);
  final language = ValueNotifier<String>('en');
  final autoScan = ValueNotifier<bool>(false);
  final sound = ValueNotifier<bool>(true);
  final haptics = ValueNotifier<bool>(true);
  final autoDelete = ValueNotifier<String>('never');


  static const Map<String, Locale> languageLocales = {
    'en': Locale('en'),
    'ar': Locale('ar'),
  };

  static const Map<String, String> languageLabels = {
    'en': 'English',
    'ar': 'العربية',
  };

  Locale get currentLocale =>
      languageLocales[language.value] ?? const Locale('en');

  ThemeMode get themeMode => switch (theme.value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  String get themeLabel => switch (theme.value) {
    'light' => 'Light',
    'dark' => 'Dark',
    _ => 'System',
  };

  String get autoDeleteLabel => switch (autoDelete.value) {
    '7days' => '7 days',
    '30days' => '30 days',
    '90days' => '90 days',
    _ => 'Never',
  };

  String get languageLabel => languageLabels[language.value] ?? 'English';

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();

    theme.value = _prefs.getString(_Keys.theme) ?? 'system';
    amoled.value = _prefs.getBool(_Keys.amoled) ?? false;
    language.value = _prefs.getString(_Keys.language) ?? 'en';
    autoScan.value = _prefs.getBool(_Keys.autoScan) ?? false;
    sound.value = _prefs.getBool(_Keys.sound) ?? true;
    haptics.value = _prefs.getBool(_Keys.haptics) ?? true;
    autoDelete.value = _prefs.getString(_Keys.autoDelete) ?? 'never';
  }


  Future<void> setTheme(String value) async {
    theme.value = value;
    await _prefs.setString(_Keys.theme, value);
  }

  Future<void> setLanguage(String code) async {
    language.value = code;
    await _prefs.setString(_Keys.language, code);
  }

  Future<void> setAutoDelete(String value) async {
    autoDelete.value = value;
    await _prefs.setString(_Keys.autoDelete, value);
  }

  Future<void> setAmoled(bool value) async {
    amoled.value = value;
    await _prefs.setBool(_Keys.amoled, value);
  }

  Future<void> setAutoScan(bool value) async {
    autoScan.value = value;
    await _prefs.setBool(_Keys.autoScan, value);
  }

  Future<void> setSound(bool value) async {
    sound.value = value;
    await _prefs.setBool(_Keys.sound, value);
  }

  Future<void> setHaptics(bool value) async {
    haptics.value = value;
    await _prefs.setBool(_Keys.haptics, value);
  }
}
