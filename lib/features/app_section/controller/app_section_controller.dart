import 'package:flutter/foundation.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/services/permission_service.dart';
import 'package:qrcode_scanner_app/core/services/scanner_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';
import 'package:qrcode_scanner_app/features/app_section/data/models/app_section_screens.dart'
    show AppSectionScreens;
import 'package:qrcode_scanner_app/features/app_section/data/models/app_section_status.dart'
    show AppSectionStatus;

class AppSectionController {
  late final PermissionService _perms;
  late final ScannerService _scanner;
  late final SettingsService _settings;

  late final ValueNotifier<AppSectionStatus> screenStatus;
  late AppSectionScreens currentScreen;

  AppSectionController() {
    _perms = PermissionService.instance;
    _scanner = ScannerService.instance;
    _settings = SettingsService.instance;
    screenStatus = ValueNotifier(AppSectionStatus.loading);
    currentScreen = AppSectionScreens.centerScreen;
    checkPermissions();
  }

  ValueNotifier<bool> get activeCenterAnimation => _scanner.detectedNotifier;
  bool get isAnimationActive => _scanner.isDetected;
  String get missedPermissionStr => _perms.missedPermissionsStr;

  Future<void> checkPermissions() async {
    screenStatus.value = AppSectionStatus.loading;
    if (!(await _perms.isRequiredGranted)) {
      screenStatus.value = AppSectionStatus.blockPerms;
    } else {
      screenStatus.value = AppSectionStatus.success;
    }
  }

  Future<void> onAppResumed() async {
    if (currentScreen == AppSectionScreens.scan) {
      try {
        await _scanner.startController();
        _scanner.clearDetection();
      } catch (e) {
        screenStatus.value = AppSectionStatus.cameraError;
        return;
      }
    }
    screenStatus.value = AppSectionStatus.success;
  }

  Future<void> onAppPaused() async {
    await _scanner.stopController();
    _scanner.clearDetection();
  }

  Future<bool> navigateOnSelect(AppSectionScreens selectedScreen) async {
    if (selectedScreen == currentScreen) {
      final isCurrentlyScan = AppSectionScreens.scan == currentScreen;
      if (isCurrentlyScan && _scanner.isDetected && !_settings.autoScan) {
        return true;
      }
      return false;
    }

    final goingToScan = selectedScreen == AppSectionScreens.scan;
    currentScreen = selectedScreen;

    if (goingToScan) {
      await onAppResumed();
    } else {
      await onAppPaused();
    }
    return false;
  }

  List<QRCodeModel>? getDetailsData() => _scanner.currentModels;

  Future<void> dispose() async {
    await _scanner.stopController();
    screenStatus.dispose();
  }
}
