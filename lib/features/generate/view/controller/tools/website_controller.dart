import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show PopularType;
import 'package:qrcode_scanner_app/features/generate/view/controller/interface/generate_template_controller.dart'
    show PopularTemplateController;

class WebsiteController implements PopularTemplateController {
  late TextEditingController _url;

  TextEditingController get urlController => _url;

  @override
  final String title;
  @override
  final String iconSvgPath;
  WebsiteController({required this.title, required this.iconSvgPath});

  @override
  String buildQrData() {
    return _url.text.trim();
  }

  @override
  void dispose() {
    _url.dispose();
  }

  @override
  void init() {
    _url = TextEditingController();
  }

  @override
  BarcodeType get dataType => BarcodeType.url;
  @override
  PopularType get gDataType => PopularType.website;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;
}
