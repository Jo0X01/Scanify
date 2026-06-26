import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode_scanner_app/core/constants/app_helpers.dart';
import 'package:qrcode_scanner_app/core/extensions/qrcode_model_action.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/services/hive_service.dart';
import 'package:qrcode_scanner_app/core/services/scanner_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailsController {
  late final SettingsService _setting;
  late final ScannerService _scanner;
  late final HiveService _hiveService;
  late final List<QRCodeModel>? qrData;
  late final ValueNotifier<List<QRCodeModel>?> qrDataListener;
  late final ScreenshotController _screenshotController;

  ScreenshotController get screenshotController => _screenshotController;

  String get locale => _setting.language.languageCode;
  bool get showAllDetails => _setting.showFullDetails;
  bool get isQrDataEmpty => qrData?.isEmpty ?? true;
  bool get isJustOneQr => qrData?.length == 1;
  int get qrLength => qrData?.length ?? 0;

  QRCodeModel get qrModel => qrData!.first;

  DetailsController([List<QRCodeModel>? qrModel]) {
    _setting = SettingsService.instance;
    _hiveService = HiveService.instance;
    _scanner = ScannerService.instance;
    _screenshotController = ScreenshotController();
    qrData = qrModel ?? _scanner.currentModels;
    qrDataListener = ValueNotifier(qrData);
    debugPrint(
      "DetailsController created with qrData: ${qrData?.map((e) => e.data).join(", ")}",
    );
    if (qrData != null && qrData!.isNotEmpty) {
      for (final item in qrData!) {
        if (item.id != null) {
          _hiveService.put(item.id, item);
        }
      }
    }
  }

  void removeQrByIndex(QRCodeModel item) {
    debugPrint(qrData.toString());
    if (qrData!.remove(item) && qrData!.isNotEmpty) {
      qrDataListener.value = qrData?.toList();
    }
    debugPrint(qrData.toString());
  }

  QRCodeModel getQrByIndex(int index) {
    return qrData!.elementAt(index);
  }

  String? getQrDate(QRCodeModel qr) {
    if (qr.date == null) return null;
    return AppHelpers.getReadableDate(
      qr.date,
      pattern: "d MMM yyyy · h:mm a",
      locale: _setting.language.languageCode,
    );
  }

  bool get canOpen => qrModel.hasAction;

  Future<void> openAction() async {
    if (qrModel.hasAction) {
      await qrModel.openAction();
    }
  }

  Future<bool> copyTextToClipboard([String? text]) async {
    try {
      text = text ?? qrModel.data;
      if (text == null) return false;
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> copyImageToClipboard() async {
    if (isQrDataEmpty) {
      return false;
    }
    try {
      final bytes = await screenshotController.capture();
      if (bytes == null) {
        return false;
      }
      await Pasteboard.writeImage(bytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> shareTo() async {
    if (isQrDataEmpty) {
      return false;
    }
    try {
      final tempDir = await getTemporaryDirectory();
      final image = await screenshotController.captureAndSave(tempDir.path);
      if (image == null) {
        return false;
      }
      final result = await SharePlus.instance.share(
        ShareParams(text: qrModel.data, files: [XFile(image)]),
      );
      return result.status == ShareResultStatus.success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveToGallery() async {
    if (isQrDataEmpty) {
      return false;
    }
    try {
      final path = await screenshotController.captureAndSave(
        await AppHelpers.getDefaultSavePath(),
      );
      if (path == null) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  int get errorCorrectionLevel => _setting.errorCorrection.value;
}
