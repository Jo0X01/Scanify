import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart'
    show PopularTemplateController;

class EmailController implements PopularTemplateController {
  @override
  BarcodeType get dataType => BarcodeType.email;

  @override
  PopularType get gDataType => PopularType.email;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  @override
  final String title;
  @override
  final String iconSvgPath;

  EmailController({required this.title, required this.iconSvgPath});

  late TextEditingController _subject;
  late TextEditingController _body;
  late TextEditingController _email;

  TextEditingController get emailController => _email;
  TextEditingController get subjectController => _subject;
  TextEditingController get bodyController => _body;

  String get subject => _subject.text.trim();
  String get body => _body.text.trim();
  String get email => _email.text.trim();

  @override
  void init() {
    _subject = TextEditingController();
    _body = TextEditingController();
    _email = TextEditingController();
  }

  @override
  String buildQrData() {
    final buffer = StringBuffer();
    buffer.write('mailto:$email');
    final params = <String>[];
    if (subject.isNotEmpty) {
      params.add('subject=${Uri.encodeComponent(subject)}');
    }
    if (body.isNotEmpty) {
      params.add('body=${Uri.encodeComponent(body)}');
    }
    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }
    return buffer.toString();
  }

  @override
  void dispose() {
    _email.dispose();
    _subject.dispose();
    _body.dispose();
  }
}
