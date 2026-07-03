import 'package:flutter/material.dart' show ThemeMode;
import 'package:scanify/core/l10n/app_localizations.dart';

enum AppThemeMode {
  system(0),
  dark(1),
  light(2);

  final int value;
  const AppThemeMode(this.value);

  String label(AppLocalizations l) => switch (this) {
    AppThemeMode.system => l.themeSystem,
    AppThemeMode.dark => l.themeDark,
    AppThemeMode.light => l.themeLight,
  };

  ThemeMode get appTheme => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.light => ThemeMode.light,
  };

  static Map<AppThemeMode, String> asMapLabel(AppLocalizations l) => {
    AppThemeMode.system: AppThemeMode.system.label(l),
    AppThemeMode.dark: AppThemeMode.dark.label(l),
    AppThemeMode.light: AppThemeMode.light.label(l),
  };
}
