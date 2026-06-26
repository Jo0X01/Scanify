import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart'
    show AppLocalizations;

enum AutoClearDetectionDelay {
  auto(1),
  after1Sec(2),
  after5Sec(6),
  after10Sec(11),
  after15Sec(16),
  after30Sec(31),
  after1Min(61);

  final int value;
  const AutoClearDetectionDelay(this.value);

  String label(AppLocalizations l) => switch (this) {
    AutoClearDetectionDelay.auto => l.autoDelete,
    AutoClearDetectionDelay.after1Sec => l.after1Sec,
    AutoClearDetectionDelay.after5Sec => l.after5Sec,
    AutoClearDetectionDelay.after10Sec => l.after10Sec,
    AutoClearDetectionDelay.after15Sec => l.after15Sec,
    AutoClearDetectionDelay.after30Sec => l.after30Sec,
    AutoClearDetectionDelay.after1Min => l.after1Min,
  };

  static Map<AutoClearDetectionDelay, String> asMapLabel(AppLocalizations l) => {
    AutoClearDetectionDelay.auto: l.autoDelete,
    AutoClearDetectionDelay.after1Sec: l.after1Sec,
    AutoClearDetectionDelay.after5Sec: l.after5Sec,
    AutoClearDetectionDelay.after10Sec: l.after10Sec,
    AutoClearDetectionDelay.after15Sec: l.after15Sec,
    AutoClearDetectionDelay.after30Sec: l.after30Sec,
    AutoClearDetectionDelay.after1Min: l.after1Min,
  };
}
