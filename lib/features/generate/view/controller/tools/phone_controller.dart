import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart'
    show PopularTemplateController;

class PhoneController implements PopularTemplateController {
  late TextEditingController _phone;

  TextEditingController get phoneController => _phone;

  @override
  final String title;
  @override
  final String iconSvgPath;
  PhoneController({required this.title, required this.iconSvgPath});

  @override
  String buildQrData() {
    final val = _phone.text.trim().replaceAll("+", "");
    return "tel:+$val";
  }

  @override
  void dispose() {
    _phone.dispose();
  }

  @override
  void init() {
    _phone = TextEditingController();
  }

  @override
  BarcodeType get dataType => BarcodeType.phone;
  @override
  PopularType get gDataType => PopularType.phone;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;
}
