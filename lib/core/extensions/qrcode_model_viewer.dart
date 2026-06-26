import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeType;
import 'package:qrcode_scanner_app/core/constants/app_helpers.dart';
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_type_parser.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart'
    show QRCodeModel;

extension XQrCodeModelViewer on QRCodeModel {
  Map<String, String?>? viewData(AppLocalizations l) => switch (type) {
    null => null,
    BarcodeType.unknown => null,
    BarcodeType.url => null,
    BarcodeType.isbn => null,
    BarcodeType.text => null,
    BarcodeType.driverLicense => null,
    BarcodeType.wifi => _wifiView(l),
    BarcodeType.email => _emailView(l),
    BarcodeType.phone => _phoneView(l),
    BarcodeType.sms => _smsView(l),
    BarcodeType.geo => _geoView(l),
    BarcodeType.contactInfo => _contactView(l),
    BarcodeType.calendarEvent => _calendarView(l),
    BarcodeType.product => _productView(l),
  };

  Map<String, String?>? _calendarView(AppLocalizations l) {
    final event = parseCalendarEvent(data);
    if (event == null) return null;
    return {
      l.calendarSummary: event.summary,
      l.calendarLocation: event.location,
      l.calendarDescription: event.description,
      l.calendarStartDate: AppHelpers.getReadableDate(event.start?.millisecondsSinceEpoch),
      l.calendarEndDate: AppHelpers.getReadableDate(event.end?.millisecondsSinceEpoch),
    };
  }

  Map<String, String?>? _contactView(AppLocalizations l) {
    final contact = parseContact(data);
    if (contact == null) return null;
    return {
      l.contactFirstName: contact.name?.first,
      l.contactLastName: contact.name?.last,
      l.contactOrganization: contact.organization,
      l.contactTitle: contact.title,
      l.contactPhone: contact.phones.firstOrNull?.number,
      l.contactEmail: contact.emails.firstOrNull?.address,
      l.contactAddress: contact.addresses.firstOrNull?.addressLines.join(', '),
      l.contactWebsite: contact.urls.firstOrNull,
    };
  }

  Map<String, String?>? _wifiView(AppLocalizations l) {
    final wifi = parseWifi(data);
    if (wifi == null) return null;
    return {
      l.wifiSsid: wifi.ssid,
      l.wifiPassword: wifi.password,
      l.wifiEncryption: wifi.encryptionType.name,
    };
  }

  Map<String, String?>? _emailView(AppLocalizations l) {
    final email = parseEmail(data);
    if (email == null) return null;
    return {
      l.emailAddress: email.address,
      l.emailSubject: email.subject,
      l.emailBody: email.body,
    };
  }

  Map<String, String?>? _smsView(AppLocalizations l) {
    final sms = parseSms(data);
    if (sms == null) return null;
    return {l.smsNumber: sms.phoneNumber, l.smsMessage: sms.message};
  }

  Map<String, String?>? _geoView(AppLocalizations l) {
    final geo = parseGeo(data);
    if (geo == null) return null;
    return {
      l.geoLatitude: geo.latitude.toString(),
      l.geoLongitude: geo.longitude.toString(),
    };
  }

  Map<String, String?>? _phoneView(AppLocalizations l) {
    final phone = parsePhone(data);
    if (phone == null) return null;
    return {l.phoneNumber: phone.number, l.phoneType: phone.type.name};
  }

  Map<String, String?>? _productView(AppLocalizations l) => {
    l.productBarcode: data,
  };
}
