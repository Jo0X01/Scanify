import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:scanify/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart'
    show PopularTemplateController;

class SmsController implements PopularTemplateController {
  late TextEditingController _phone;
  late TextEditingController _message;

  TextEditingController get phoneController => _phone;
  TextEditingController get messageController => _message;

  @override
  final String title;
  @override
  final String iconSvgPath;
  SmsController({required this.title, required this.iconSvgPath});

  @override
  String buildQrData() {
    final phone = _phone.text.trim().replaceAll("+", "");
    final message = _message.text.trim();
    if (message.isEmpty) {
      return 'sms:+$phone';
    }
    return 'sms:+$phone?body=${Uri.encodeComponent(message)}';
  }

  @override
  void dispose() {
    _phone.dispose();
    _message.dispose();
  }

  @override
  void init() {
    _phone = TextEditingController();
    _message = TextEditingController();
  }

  @override
  BarcodeType get dataType => BarcodeType.sms;
  @override
  PopularType get gDataType => PopularType.sms;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;
}
