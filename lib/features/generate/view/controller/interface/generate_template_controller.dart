import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:scanify/core/enum/tool_data_types.dart';

abstract interface class GenerateTemplateController {
  String get title;
  String get iconSvgPath;
  BarcodeType get dataType;
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;
  String buildQrData();
  void init();
  void dispose();
}

abstract interface class PopularTemplateController
    extends GenerateTemplateController {
  PopularType get gDataType;
}

abstract interface class SocialTemplateController
    extends GenerateTemplateController {
  SocialType get gDataType;
}

abstract interface class BarcodeTemplateController
    extends GenerateTemplateController {
  BarcodeToolType get gDataType;
}
