import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/services/scanner_service.dart';
import 'package:qrcode_scanner_app/core/services/settings_service.dart';
import 'package:qrcode_scanner_app/core/utils/device_util.dart';

class ScanController {
  ScanController() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.unrestricted,
      detectionTimeoutMs: 750,
    );
    _scanner.setController(_controller);
  }

  late final ScannerService _scanner = ScannerService.instance;
  late final SettingsService _settings = SettingsService.instance;
  late final MobileScannerController _controller;
  bool _isProcessing = false;

  MobileScannerController? get controller => _scanner.getCurrentController();
  ValueNotifier<bool> get detectListener => _scanner.detectedNotifier;
  List<List<Offset>>? get detectedCorners => _scanner.detectedCorners;
  bool get isDetect => _scanner.isDetected;
  List<QRCodeModel>? get currentModels => _scanner.currentModels;

  Future<List<QRCodeModel>?> onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return null;
    try {
      _isProcessing = true;
      debugPrint('ScanController.onDetect: autoScan=${_settings.autoScan}');
      _scanner.setScanQrOnly(_settings.scanQrCodeOnly);
      _scanner.cancelClearTimer();

      if (_scanner.isAlreadyCaptured(capture)) {
        if (_scanner.updateCorners(capture)) {
          _scanner.refreshDetection();
        }
        _scanner.startClearTimer(_settings.autoClearDetection);
        _isProcessing = false;
        return null;
      }

      final model = _scanner.handleCapture(capture, limit: 3);
      debugPrint('ScanController.onDetect: model returned=${model != null}');
      if (model == null) {
        _scanner.startClearTimer(_settings.autoClearDetection);
        _isProcessing = false;
        return null;
      }

      if (_settings.sound) await DeviceUtil.playClickSound();
      if (_settings.haptics) await DeviceUtil.vibration();

      if (!_settings.autoScan) {
        debugPrint(
          'ScanController.onDetect: autoScan disabled, returning null',
        );
        _scanner.startClearTimer(_settings.autoClearDetection);
        _isProcessing = false;
        return null;
      }
      _isProcessing = false;
      return model;
    } catch (e, stackTrace) {
      debugPrint('ScanController.onDetect error: $e\n$stackTrace');
      _isProcessing = false;
      return null;
    } finally {
      // always re-arm the clear timer unless we returned a result for navigation
    }
  }

  void clearDetection() => _scanner.clearDetection();

  Future<void> resumeCamera() async {
    await _scanner.restartController();
    _scanner.clearDetection();
  }

  Future<void> pauseCamera() async {
    await _scanner.stopController();
    _scanner.clearDetection();
  }

  Future<void> toggleTorch() async {
    try {
      await _scanner.toggleTorch();
    } catch (e) {
      debugPrint('ScanController.toggleTorch error: $e');
    }
  }

  Future<List<QRCodeModel>?> pickFromGallery() async {
    try {
      _scanner.setScanQrOnly(_settings.scanQrCodeOnly);
      return await _scanner.pickFromGallery();
    } catch (e, stackTrace) {
      debugPrint('ScanController.pickFromGallery error: $e\n$stackTrace');
      return null;
    }
  }

  Future<void> dispose() async {
    await _scanner.stopController();
  }
}
