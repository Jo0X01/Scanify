
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart' show QRCodeModel;

extension XQrModelParser on QRCodeModel {
  Object? fromType(BarcodeType type, String? data) {
    if (data == null) return null;
    return switch (type) {
      BarcodeType.contactInfo => parseContact(data),
      BarcodeType.email => parseEmail(data),
      BarcodeType.phone => parsePhone(data),
      BarcodeType.sms => parseSms(data),
      BarcodeType.wifi => parseWifi(data),
      BarcodeType.geo => parseGeo(data),
      BarcodeType.calendarEvent => parseCalendarEvent(data),
      BarcodeType.driverLicense => null,
      _ => null,
    };
  }

  ContactInfo? parseContact(String? data) {
    if (data == null) return null;
    final lines = data
        .replaceAll('\r\n ', '')
        .replaceAll('\r\n\t', '')
        .replaceAll('\n ', '')
        .split(RegExp(r'\r?\n'))
        .where((l) => l.isNotEmpty)
        .toList();

    String? firstName, lastName;
    final phones = <Phone>[];
    final emails = <Email>[];
    Address? address;
    String? org;
    String? title;
    final urls = <String>[];

    for (final line in lines) {
      final col = line.indexOf(':');
      if (col == -1) continue;

      final key = line.substring(0, col).toUpperCase();
      final value = line.substring(col + 1).trim();
      if (value.isEmpty) continue;
      switch (key.split(';').first) {
        case 'FN':
          final parts = value.split(' ');
          firstName = parts.first;
          lastName = parts.length > 1 ? parts.skip(1).join(' ') : null;
        case 'N':
          // N:LastName;FirstName;Middle;Prefix;Suffix
          final parts = value.split(';');
          lastName = parts.isNotEmpty ? parts[0] : null;
          firstName = parts.length > 1 ? parts[1] : null;
        case 'TEL':
          final phoneType = switch (key
              .split(';')
              .lastWhere((p) => p.startsWith('TYPE='), orElse: () => '')) {
            'TYPE=CELL' => PhoneType.mobile,
            'TYPE=MOBILE' => PhoneType.mobile,
            'TYPE=WORK' => PhoneType.work,
            'TYPE=HOME' => PhoneType.home,
            'TYPE=FAX' => PhoneType.fax,
            _ => PhoneType.unknown,
          };
          phones.add(Phone(number: value, type: phoneType));
        case 'EMAIL':
          final emailType = switch (key
              .split(';')
              .lastWhere((p) => p.startsWith('TYPE='), orElse: () => '')) {
            'TYPE=WORK' => EmailType.work,
            'TYPE=HOME' => EmailType.home,
            _ => EmailType.unknown,
          };
          emails.add(Email(address: value, type: emailType));
        case 'ADR':
          // ADR:;;Street;City;State;ZIP;Country
          final parts = value.split(';');
          final lines = [
            if (parts.length > 2 && parts[2].isNotEmpty) parts[2], // street
            if (parts.length > 3 && parts[3].isNotEmpty) parts[3], // city
            if (parts.length > 4 && parts[4].isNotEmpty) parts[4], // state
            if (parts.length > 5 && parts[5].isNotEmpty) parts[5], // zip
            if (parts.length > 6 && parts[6].isNotEmpty) parts[6], // country
          ];
          address = Address(addressLines: lines);
        case 'ORG':
          org = value;
        case 'TITLE':
          title = value;
        case 'URL':
          urls.add(value);
      }
    }

    return ContactInfo(
      name: PersonName(first: firstName, last: lastName),
      phones: phones,
      emails: emails,
      addresses: address != null ? [address] : [],
      urls: urls,
      organization: org,
      title: title,
    );
  }

  Email? parseEmail(String? raw) {
    if (raw == null) return null;
    if (!raw.startsWith('mailto:')) return null;
    final uri = Uri.tryParse(raw);
    if (uri == null) return null;
    return Email(
      address: uri.path,
      subject: uri.queryParameters['subject'],
      body: uri.queryParameters['body'],
    );
  }

  Phone? parsePhone(String? raw) {
    if (raw == null || !raw.startsWith('tel:')) return null;
    final number = raw.replaceFirst('tel:', '').trim();
    if (number.isEmpty) return null;
    return Phone(number: number);
  }

  SMS? parseSms(String? raw) {
    if (raw == null || !raw.startsWith('sms:')) return null;
    final uri = Uri.tryParse(raw);
    if (uri == null) return null;
    return SMS(phoneNumber: uri.path, message: uri.queryParameters['body']);
  }

  WiFi? parseWifi(String? raw) {
    if (raw == null || !raw.startsWith('WIFI:')) return null;

    final params = <String, String>{};
    final content = raw.replaceFirst('WIFI:', '');

    for (final part in content.split(';')) {
      final col = part.indexOf(':');
      if (col == -1) continue;
      final key = part.substring(0, col);
      final value = part.substring(col + 1);
      params[key] = value;
    }

    return WiFi(
      ssid: params['S'],
      password: params['P'],
      encryptionType: switch (params['T']?.toUpperCase()) {
        'WPA' => EncryptionType.wpa,
        'WEP' => EncryptionType.wep,
        'NONE' => EncryptionType.open,
        _ => EncryptionType.open,
      },
    );
  }

  GeoPoint? parseGeo(String? raw) {
    if (raw == null || !raw.toUpperCase().startsWith('GEO:')) return null;
    final coords = raw
        .replaceFirst(RegExp(r'GEO:', caseSensitive: false), '')
        .trim();
    final parts = coords.split(',');
    if (parts.length < 2) return null;
    return GeoPoint(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }

  CalendarEvent? parseCalendarEvent(String? raw) {
    if (raw == null || !raw.contains('BEGIN:VEVENT')) return null;

    final lines = raw
        .replaceAll('\r\n ', '')
        .replaceAll('\n ', '')
        .split(RegExp(r'\r?\n'))
        .where((l) => l.isNotEmpty);

    final params = <String, String>{};
    for (final line in lines) {
      final col = line.indexOf(':');
      if (col == -1) continue;
      params[line.substring(0, col)] = line.substring(col + 1).trim();
    }

    return CalendarEvent(
      summary: params['SUMMARY'],
      location: params['LOCATION'],
      description: params['DESCRIPTION'],
      start: _parseDate(params['DTSTART']),
      end: _parseDate(params['DTEND']),
    );
  }

  static DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(
        '${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}'
        'T${value.substring(9, 11)}:${value.substring(11, 13)}:${value.substring(13, 15)}Z',
      );
    } catch (_) {
      return null;
    }
  }
}
