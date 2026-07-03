import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanify/core/constants/app_helpers.dart';
import 'package:scanify/core/utils/logger.dart' show AppLogger;
import 'package:scanify/core/extensions/qrcode_model_action.dart';
import 'package:scanify/core/managers/notification_manager.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/core/services/settings_service.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailsController {
  late final SettingsService _setting;
  late final ValueNotifier<Set<QRCodeModel>> qrDataListener;
  late final ScreenshotController _screenshotController;

  ScreenshotController get screenshotController => _screenshotController;
  Set<QRCodeModel> get qrData => qrDataListener.value;

  String get locale => _setting.language.languageCode;
  bool get showAllDetails => _setting.showFullDetails;
  bool get isQrDataEmpty => qrData.isEmpty;
  bool get isJustOneQr => qrData.length == 1;
  int get qrLength => qrData.length;
  QRCodeModel get qrModel => qrData.first;
  bool get canOpen => qrModel.hasAction;
  int get errorCorrectionLevel => _setting.errorCorrection.value;

  DetailsController([Set<QRCodeModel>? qrModel]) {
    _setting = SettingsService.instance;
    _screenshotController = ScreenshotController();
    qrDataListener = ValueNotifier(
      qrModel ?? ScannerManager.instance.currentModels,
    );
    saveToDB();
  }

  Future<void> saveToDB() async {
    if (_setting.enableHistory) {
      if (await ScannerManager.instance.saveQrModels(qrData)) {
        NotificationManager.instance.notifiySaved();
      }
    }
  }

  void removeQrByIndex(QRCodeModel item) {
    if (qrData.remove(item)) {
      qrDataListener.value = qrData.toSet();
    }
  }

  QRCodeModel getQrByIndex(int index) => qrData.elementAt(index);

  String? getQrDate(QRCodeModel qr) {
    if (qr.date == null) return null;
    return AppHelpers.getReadableDate(
      qr.date,
      pattern: "d MMM yyyy · h:mm a",
      locale: _setting.language.languageCode,
    );
  }

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
    } catch (e, st) {
      AppLogger.log('copyTextToClipboard failed', e, st);
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
    } catch (e, st) {
      AppLogger.log('copyImageToClipboard failed', e, st);
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
    } catch (e, st) {
      AppLogger.log('shareTo failed', e, st);
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
    } catch (e, st) {
      AppLogger.log('saveToGallery failed', e, st);
      return false;
    }
  }
}
