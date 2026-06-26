import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeType, BarcodeFormat;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart' show PopularTemplateController;

class TextController implements PopularTemplateController {
  late TextEditingController _text;

  TextEditingController get textController => _text;

  @override
  final String title;
  @override
  final String iconSvgPath;
  TextController({required this.title, required this.iconSvgPath});

  @override
  String buildQrData() {
    return _text.text.trim();
  }

  @override
  void dispose() {
    _text.dispose();
  }

  @override
  void init() {
    _text = TextEditingController();
  }

  @override
  BarcodeType get dataType => BarcodeType.text;
  @override
  PopularType get gDataType => PopularType.text;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;
}
