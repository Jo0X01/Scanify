import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanify/core/utils/logger.dart' show AppLogger;
import 'package:scanify/core/managers/notification_manager.dart';
import 'package:scanify/core/managers/scanner_manager.dart';
import 'package:scanify/core/models/qrcode_model.dart';
import 'package:scanify/core/services/permission_service.dart';

enum ScanState { loading, permission, normal }

class ScanController {
  ScanController() {
    _scannerManager = ScannerManager.instance;
    _perms = PermissionService.instance;
    screenState = ValueNotifier(ScanState.loading);
  }

  late final ValueNotifier<ScanState> screenState;
  late final PermissionService _perms;

  void init() async {
    await checkPermissions();
    ScannerManager.instance.addCameraListener(
      NotificationManager.instance.notifyCameraState,
    );
  }

  Future<void> checkPermissions() async {
    await _perms.requestRequiredPermissions();
    await _applyPermissionStatus();
  }

  Future<void> refreshPermissionStatus() async {
    await _applyPermissionStatus();
  }

  Future<void> _applyPermissionStatus() async {
    if (!(await _perms.isRequiredGranted)) {
      screenState.value = ScanState.permission;
    } else {
      screenState.value = ScanState.normal;
      await _scannerManager.startDetection();
    }
  }

  late final ScannerManager _scannerManager;

  MobileScannerController get scanController => _scannerManager.controller;

  String get missedPermissionStr => _perms.missedPermissionsAsStr();
  ValueNotifier get detectListener => _scannerManager.detectListener;
  ValueNotifier<bool> get torchState => _scannerManager.torchState;

  bool get isTorchActive => _scannerManager.isTorchActive;
  bool get autoScan => _scannerManager.autoScan;

  Set<QRCodeModel> get models => _scannerManager.currentModels;

  bool get isDetected => _scannerManager.isDetected;
  List<List<Offset>>? get detectedCorners => _scannerManager.detectedCorners;
  Size? get cameraResolution => _scannerManager.controller.value.size;

  Future<Set<QRCodeModel>> onDetect(BarcodeCapture capture) async {
    try {
      final parseCapture = _scannerManager.analyzeFromCameraScan(capture);
      if (parseCapture.isEmpty) {
        return {};
      }
      if (!_scannerManager.autoScan) {
        return {};
      }
      return parseCapture;
    } catch (e, st) {
      AppLogger.log('onDetect failed', e, st);
      return {};
    }
  }

  Future<void> resumeCamera() async {
    await _scannerManager.turnTorchOff();
    await _scannerManager.startDetection();
  }

  Future<void> pauseCamera() async {
    await _scannerManager.stopDetection();
    await _scannerManager.turnTorchOff();
  }

  void toggleTorch() => _scannerManager.toggleTorch();

  Future<Set<QRCodeModel>> pickFromGallery() async {
    _scannerManager.clearDetection();
    await _scannerManager.stopDetection();
    await _scannerManager.turnTorchOff();
    final result = await _scannerManager.pickAndAnalyzeFromGal();
    if (result.isEmpty) {
      await _scannerManager.startDetection();
    } else {
      await _scannerManager.stopDetection();
      await _scannerManager.turnTorchOff();
    }
    return result;
  }

}
