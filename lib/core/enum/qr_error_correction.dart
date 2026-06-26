import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart'
    show AppLocalizations;

enum QrErrorCorrectionLevel {
  auto(1),
  low(1),
  med(0),
  quartile(3),
  high(2);

  final int value;
  const QrErrorCorrectionLevel(this.value);

  String label(AppLocalizations l) => switch (this) {
    QrErrorCorrectionLevel.auto => l.qrErrorCorrectionLvLAuto,
    QrErrorCorrectionLevel.low => l.qrErrorCorrectionLowLvL,
    QrErrorCorrectionLevel.med => l.qrErrorCorrectionMedLvL,
    QrErrorCorrectionLevel.quartile => l.qrErrorCorrectionQuartileLvL,
    QrErrorCorrectionLevel.high => l.qrErrorCorrectionHighLvL,
  };

  static Map<QrErrorCorrectionLevel, String> asMapLabel(AppLocalizations l) => {
    QrErrorCorrectionLevel.auto: l.qrErrorCorrectionLvLAuto,
    QrErrorCorrectionLevel.low: l.qrErrorCorrectionLowLvL,
    QrErrorCorrectionLevel.med: l.qrErrorCorrectionMedLvL,
    QrErrorCorrectionLevel.high: l.qrErrorCorrectionHighLvL,
  };
}
