import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart'
    show BarcodeType, BarcodeFormat;
import 'package:scanify/core/helpers/social_url_resolver.dart'
    show SocialUrlResolver;
import 'package:scanify/core/enum/tool_data_types.dart';
import 'package:scanify/features/generate/view/controller/interface/generate_template_controller.dart';

class SocialController implements SocialTemplateController {
  @override
  final String title;
  @override
  final String iconSvgPath;

  @override
  BarcodeType get dataType => BarcodeType.url;
  @override
  SocialType get gDataType => gType;
  @override
  BarcodeFormat get dataFormat => BarcodeFormat.qrCode;

  bool get hasPhone => gDataType.hasPhone;
  bool get hasUsername => gDataType.hasUsername;

  final String? Function(String?) usernameValidator;

  final SocialType gType;
  late final String desc;
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;

  SocialController({
    required this.title,
    required this.iconSvgPath,
    required this.gType,
    required this.desc,
    required this.usernameValidator,
  });

  @override
  void init() {
    if (hasUsername) usernameController = TextEditingController();
    if (hasPhone) phoneController = TextEditingController();
  }

  @override
  void dispose() {
    if (hasUsername) usernameController.dispose();
    if (hasPhone) phoneController.dispose();
  }

  @override
  String buildQrData() {
    if (hasPhone) {
      return SocialUrlResolver.build(gDataType, phoneController.text.trim());
    }
    if (hasUsername) {
      return SocialUrlResolver.build(gDataType, usernameController.text.trim());
    }
    return "";
  }
}
