import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart';

class ContactController implements PopularTemplateController {
  @override
  PopularType get gDataType => PopularType.contact;
  @override
  BarcodeType get dataType => BarcodeType.contactInfo;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  final String title;
  @override
  final String iconSvgPath;

  ContactController({required this.title, required this.iconSvgPath});

  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _company;
  late TextEditingController _website;
  late TextEditingController _job;
  late TextEditingController _address;
  late TextEditingController _note;

  TextEditingController get nameController => _name;
  TextEditingController get phoneController => _phone;
  TextEditingController get emailController => _email;
  TextEditingController get companyController => _company;
  TextEditingController get websiteController => _website;
  TextEditingController get jobController => _job;
  TextEditingController get addressController => _address;
  TextEditingController get noteController => _note;

  String get name => _name.text.trim();
  String get phone => _phone.text.trim();
  String get email => _email.text.trim();
  String get company => _company.text.trim();
  String get website => _website.text.trim();
  String get job => _job.text.trim();
  String get address => _address.text.trim();
  String get note => _note.text.trim();

  @override
  void init() {
    _name = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
    _company = TextEditingController();
    _website = TextEditingController();
    _job = TextEditingController();
    _address = TextEditingController();
    _note = TextEditingController();
  }

  @override
  String buildQrData() { 
    final buffer = StringBuffer()
      ..writeln("BEGIN:VCARD")
      ..writeln("VERSION:3.0")
      ..writeln("FN:$name");
    if (phone.isNotEmpty) {
      final val = phone.replaceAll("+", "").trim();
      buffer.writeln("TEL:+$val");
    }
    if (email.isNotEmpty) {
      buffer.writeln("EMAIL:$email");
    }
    if (company.isNotEmpty) {
      buffer.writeln("ORG:$company");
    }
    if (website.isNotEmpty) {
      buffer.writeln("URL:$website");
    }
    buffer.writeln("END:VCARD");
    return buffer.toString();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _company.dispose();
    _website.dispose();
    _job.dispose();
    _address.dispose();
    _note.dispose();
  }
  
}
