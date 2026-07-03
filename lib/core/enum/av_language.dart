import 'dart:ui';

import 'package:scanify/core/l10n/app_localizations.dart';

enum AvLanguages {
  system("System"),
  ar("العربية"),
  en("English");

  final String value;
  const AvLanguages(this.value);

  String label(AppLocalizations l) => switch (this) {
    AvLanguages.system => l.system,
    AvLanguages.ar => l.ar,
    AvLanguages.en => l.en,
  };

  String get languageCode {
    switch (this) {
      case AvLanguages.ar:
        return AvLanguages.ar.name;
      case AvLanguages.en:
        return AvLanguages.en.name;
      case AvLanguages.system:
        return PlatformDispatcher.instance.locale.languageCode;
    }
  }

  Locale get locale {
    switch (this) {
      case AvLanguages.ar:
        return const Locale('ar');
      case AvLanguages.en:
        return const Locale('en');
      case AvLanguages.system:
        return PlatformDispatcher.instance.locale;
    }
  }

  static Map<AvLanguages, String> asMapLabel(AppLocalizations l) => {
    AvLanguages.system: l.system,
    AvLanguages.ar: l.ar,
    AvLanguages.en: l.en,
  };
}
