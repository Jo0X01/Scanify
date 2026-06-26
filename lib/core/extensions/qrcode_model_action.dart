import 'package:add_2_calendar/add_2_calendar.dart' show Event, Add2Calendar;
import 'package:flutter_contacts/flutter_contacts.dart'
    show Contact, FlutterContacts, Name, Phone, Email, Organization;
import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeType;
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_type_parser.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode, launchUrl;

extension XQrModelAction on QRCodeModel {
  bool get hasAction => switch (type) {
    BarcodeType.wifi => false,
    BarcodeType.driverLicense => false,
    BarcodeType.url => true,
    BarcodeType.email => true,
    BarcodeType.phone => true,
    BarcodeType.sms => true,
    BarcodeType.geo => true,
    BarcodeType.contactInfo => true,
    BarcodeType.calendarEvent => true,
    BarcodeType.isbn => true,
    BarcodeType.product => true,
    BarcodeType.text => true,
    BarcodeType.unknown => true,
    null => false,
  };

  Future<void>? openAction() => switch (type) {
    BarcodeType.wifi => null,
    BarcodeType.driverLicense => null,
    BarcodeType.url => _launch(data),
    BarcodeType.geo => _launch(data),
    BarcodeType.email => _launch(data),
    BarcodeType.phone => _launch(data),
    BarcodeType.sms => _launch(data),
    BarcodeType.contactInfo => _saveContact(),
    BarcodeType.calendarEvent => _addToCalendar(),
    BarcodeType.isbn ||
    BarcodeType.product => _launch('https://www.barcodelookup.com/$data'),
    BarcodeType.text ||
    BarcodeType.unknown => _launch('https://www.google.com/search?q=$data'),
    null => null,
  };

  Future<void> _launch([String? url]) async {
    url = url ?? data;
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _saveContact() async {
    final info = parseContact(data);
    if (info == null) return;
    final contact = Contact(
      name: Name(first: info.name?.first ?? "", last: info.name?.last ?? ""),
      phones: info.phones.map((p) => Phone(number: p.number ?? '')).toList(),
      emails: info.emails.map((e) => Email(address: e.address ?? '')).toList(),
      organizations: info.organization != null
          ? [Organization(name: info.organization)]
          : [],
    );
    await FlutterContacts.native.showCreator(contact: contact);
  }

  Future<void> _addToCalendar() async {
    final event = parseCalendarEvent(data);
    if (event == null) return;
    final e = Event(
      title: event.summary ?? '',
      description: event.description ?? '',
      location: event.location ?? '',
      startDate: event.start ?? DateTime.now(),
      endDate: event.end ?? DateTime.now().add(const Duration(hours: 1)),
    );
    await Add2Calendar.addEvent2Cal(e);
  }
}
