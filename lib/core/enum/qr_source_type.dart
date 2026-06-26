import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';

enum QrSourceType {
  unknown(-1),
  scan(0),
  picked(1),
  generate(2);

  final int value;
  const QrSourceType(this.value);

  static Map<QrSourceType, String> asMapLabel(AppLocalizations l) => {
    QrSourceType.scan: l.scanSourceScanned,
    QrSourceType.picked: l.scanSourcePicked,
    QrSourceType.generate: l.scanSourceGenerated,
    QrSourceType.unknown: l.scanSourceUknown,
  };

  String label(AppLocalizations l) => switch (this) {
    QrSourceType.scan => l.scanSourceScanned,
    QrSourceType.picked => l.scanSourcePicked,
    QrSourceType.generate => l.scanSourceGenerated,
    QrSourceType.unknown => l.scanSourceUknown,
  };
}

extension XBarCodeType on BarcodeType {
  static Map<BarcodeType, String> asMapLabel(AppLocalizations l) => {
    BarcodeType.text: l.typeText,
    BarcodeType.product: l.typeProduct,
    BarcodeType.url: l.typeUrl,
    BarcodeType.wifi: l.typeWifi,
    BarcodeType.geo: l.typeLocation,
    BarcodeType.calendarEvent: l.typeCalendarEvent,
    BarcodeType.driverLicense: l.typeDriverLicense,
    BarcodeType.sms: l.typeSms,
    BarcodeType.phone: l.typePhone,
    BarcodeType.isbn: l.typeIsbn,
    BarcodeType.contactInfo: l.typeContact,
    BarcodeType.email: l.typeEmail,
    BarcodeType.unknown: l.typeUnknown,
  };

  String label(AppLocalizations l) => switch (this) {
    BarcodeType.contactInfo => l.typeContact,
    BarcodeType.email => l.typeEmail,
    BarcodeType.isbn => l.typeIsbn,
    BarcodeType.phone => l.typePhone,
    BarcodeType.product => l.typeProduct,
    BarcodeType.sms => l.typeSms,
    BarcodeType.text => l.typeText,
    BarcodeType.url => l.typeUrl,
    BarcodeType.wifi => l.typeWifi,
    BarcodeType.geo => l.typeLocation,
    BarcodeType.calendarEvent => l.typeCalendarEvent,
    BarcodeType.driverLicense => l.typeDriverLicense,
    _ => l.typeUnknown,
  };
}

extension XBarCodeFormat on BarcodeFormat {
  static Map<BarcodeFormat, String> asMapLabel(AppLocalizations l) => {
    BarcodeFormat.qrCode: l.formatQrCode,
    BarcodeFormat.aztec: l.formatAztec,
    BarcodeFormat.codabar: l.formatCodabar,
    BarcodeFormat.code128: l.formatCode128,
    BarcodeFormat.code39: l.formatCode39,
    BarcodeFormat.code93: l.formatCode93,
    BarcodeFormat.dataMatrix: l.formatDataMatrix,
    BarcodeFormat.ean13: l.formatEan13,
    BarcodeFormat.ean8: l.formatEan8,
    BarcodeFormat.itf14: l.formatItf14,
    BarcodeFormat.itf2of5: l.formatItf2of5,
    BarcodeFormat.itf2of5WithChecksum: l.formatitf2of5WithChecksum,
    BarcodeFormat.pdf417: l.formatPdf417,
    BarcodeFormat.upcA: l.formatUpcA,
    BarcodeFormat.upcE: l.formatUpcE,
    BarcodeFormat.unknown: l.formatUnknown,
  };

  String label(AppLocalizations l) => switch (this) {
    BarcodeFormat.code128 => l.formatCode128,
    BarcodeFormat.code39 => l.formatCode39,
    BarcodeFormat.code93 => l.formatCode93,
    BarcodeFormat.codabar => l.formatCodabar,
    BarcodeFormat.dataMatrix => l.formatDataMatrix,
    BarcodeFormat.ean13 => l.formatEan13,
    BarcodeFormat.ean8 => l.formatEan8,
    BarcodeFormat.itf2of5 => l.formatItf2of5,
    BarcodeFormat.itf2of5WithChecksum => l.formatitf2of5WithChecksum,
    BarcodeFormat.itf14 => l.formatItf14,
    BarcodeFormat.qrCode => l.formatQrCode,
    BarcodeFormat.upcA => l.formatUpcA,
    BarcodeFormat.upcE => l.formatUpcE,
    BarcodeFormat.pdf417 => l.formatPdf417,
    BarcodeFormat.aztec => l.formatAztec,
    _ => l.formatUnknown,
  };
}
