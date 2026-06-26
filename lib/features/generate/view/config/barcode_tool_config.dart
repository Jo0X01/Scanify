import 'package:mobile_scanner/mobile_scanner.dart' show BarcodeFormat;
import 'package:qrcode_scanner_app/core/constants/app_assets.dart'
    show AppIcons;
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:qrcode_scanner_app/core/utils/validator.dart' show Validator;
import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show BarcodeToolType;
import 'package:qrcode_scanner_app/features/generate/view/config/tool_config.dart'
    show ToolConfig;
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/barcode_controller.dart'
    show BarcodeController;
import 'package:qrcode_scanner_app/features/generate/view/widgets/templates/barcode_template.dart'
    show BarcodeTemplate;

ToolConfig _barcode({
  required String icon,
  required String Function(AppLocalizations) title,
  required String Function(AppLocalizations) desc,
  required BarcodeToolType toolType,
  required BarcodeFormat toolFormat,
  required String? Function(String?, AppLocalizations) validator,
}) => ToolConfig(
  icon: icon,
  title: title,
  buildController: (l) => BarcodeController(
    title: title(l),
    iconSvgPath: icon,
    desc: desc(l),
    toolType: toolType,
    validator: (val) => validator(val, l),
    toolFormat: toolFormat,
  ),
  buildTemplate: (c) =>
      BarcodeTemplate(templateController: c as BarcodeController),
);

ToolConfig getBarcodeTool(BarcodeToolType val) => switch (val) {
  BarcodeToolType.code39 => _barcode(
    icon: AppIcons.code39Icon,
    title: (l) => l.formatCode39,
    desc: (l) => l.code39Desc,
    toolType: BarcodeToolType.code39,
    toolFormat: BarcodeFormat.code39,
    validator: (val, l) => Validator.code39(val)?.message(l),
  ),

  BarcodeToolType.code93 => _barcode(
    icon: AppIcons.code93Icon,
    title: (l) => l.formatCode93,
    desc: (l) => l.code93Desc,
    toolType: BarcodeToolType.code93,
    toolFormat: BarcodeFormat.code93,
    validator: (val, l) => Validator.code93(val)?.message(l),
  ),

  BarcodeToolType.codabar => _barcode(
    icon: AppIcons.codabarIcon,
    title: (l) => l.formatCodabar,
    desc: (l) => l.codabarDesc,
    toolType: BarcodeToolType.codabar,
    toolFormat: BarcodeFormat.codabar,
    validator: (val, l) => Validator.codabar(val)?.message(l),
  ),

  BarcodeToolType.dataMatrix => _barcode(
    icon: AppIcons.dataMatrixIcon,
    title: (l) => l.formatDataMatrix,
    desc: (l) => l.dataMatrixDesc,
    toolType: BarcodeToolType.dataMatrix,
    toolFormat: BarcodeFormat.dataMatrix,
    validator: (val, l) => Validator.dataMatrix(val)?.message(l),
  ),

  BarcodeToolType.ean13 => _barcode(
    icon: AppIcons.ean13Icon,
    title: (l) => l.formatEan13,
    desc: (l) => l.ean13Desc,
    toolType: BarcodeToolType.ean13,
    toolFormat: BarcodeFormat.ean13,
    validator: (val, l) => Validator.ean13(val)?.message(l),
  ),

  BarcodeToolType.ean8 => _barcode(
    icon: AppIcons.ean8Icon,
    title: (l) => l.formatEan8,
    desc: (l) => l.ean8Desc,
    toolType: BarcodeToolType.ean8,
    toolFormat: BarcodeFormat.ean8,
    validator: (val, l) => Validator.ean8(val)?.message(l),
  ),

  BarcodeToolType.itf2of5 => _barcode(
    icon: AppIcons.itf2of5Icon,
    title: (l) => l.formatItf2of5,
    desc: (l) => l.itf2of5Desc,
    toolType: BarcodeToolType.itf2of5,
    toolFormat: BarcodeFormat.itf2of5,
    validator: (val, l) => Validator.itf2of5(val)?.message(l),
  ),

  BarcodeToolType.itf2of5WithChecksum => _barcode(
    icon: AppIcons.itf2of5csIcon,
    title: (l) => l.formatitf2of5WithChecksum,
    desc: (l) => l.itf2of5WithChecksumDesc,
    toolType: BarcodeToolType.itf2of5WithChecksum,
    toolFormat: BarcodeFormat.itf2of5WithChecksum,
    validator: (val, l) => Validator.itf2of5WithChecksum(val)?.message(l),
  ),

  BarcodeToolType.itf14 => _barcode(
    icon: AppIcons.itf14Icon,
    title: (l) => l.formatItf14,
    desc: (l) => l.itf14Desc,
    toolType: BarcodeToolType.itf14,
    toolFormat: BarcodeFormat.itf14,
    validator: (val, l) => Validator.itf14(val)?.message(l),
  ),

  BarcodeToolType.upcA => _barcode(
    icon: AppIcons.upcaIcon,
    title: (l) => l.formatUpcA,
    desc: (l) => l.upcADesc,
    toolType: BarcodeToolType.upcA,
    toolFormat: BarcodeFormat.upcA,
    validator: (val, l) => Validator.upcA(val)?.message(l),
  ),

  BarcodeToolType.upcE => _barcode(
    icon: AppIcons.upc3Icon,
    title: (l) => l.formatUpcE,
    desc: (l) => l.upcEDesc,
    toolType: BarcodeToolType.upcE,
    toolFormat: BarcodeFormat.upcE,
    validator: (val, l) => Validator.upcE(val)?.message(l),
  ),

  BarcodeToolType.pdf417 => _barcode(
    icon: AppIcons.pdf417Icon,
    title: (l) => l.formatPdf417,
    desc: (l) => l.pdf417Desc,
    toolType: BarcodeToolType.pdf417,
    toolFormat: BarcodeFormat.pdf417,
    validator: (val, l) => Validator.pdf417(val)?.message(l),
  ),

  BarcodeToolType.aztec => _barcode(
    icon: AppIcons.aztecIcon,
    title: (l) => l.formatAztec,
    desc: (l) => l.aztecDesc,
    toolType: BarcodeToolType.aztec,
    toolFormat: BarcodeFormat.aztec,
    validator: (val, l) => Validator.aztec(val)?.message(l),
  ),
  BarcodeToolType.code128 => _barcode(
    icon: AppIcons.code128Icon,
    title: (l) => l.formatCode128,
    desc: (l) => l.code128Desc,
    toolType: BarcodeToolType.code128,
    toolFormat: BarcodeFormat.code128,
    validator: (val, l) => Validator.code128(val)?.message(l),
  ),
};
