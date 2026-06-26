import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart'
    show BarcodeTemplateController;

class BarcodeController implements BarcodeTemplateController {
  @override
  BarcodeToolType get gDataType => toolType;
  @override
  BarcodeType get dataType => BarcodeType.unknown;
  @override
  BarcodeFormat get dataFormat => toolFormat;

  @override
  final String title;
  @override
  final String iconSvgPath;
  final String desc;
  final BarcodeToolType toolType;
  final BarcodeFormat toolFormat;
  late TextEditingController inputController;
  late String? Function(String?) validator;

  BarcodeController({
    required this.title,
    required this.iconSvgPath,
    required this.desc,
    required this.toolType,
    required this.toolFormat,
    required this.validator
  });

  @override
  String buildQrData() {
    return inputController.text.trim();
  }

  @override
  void dispose() {
    inputController.dispose();
  }

  @override
  void init() {
    inputController = TextEditingController();
  }
}