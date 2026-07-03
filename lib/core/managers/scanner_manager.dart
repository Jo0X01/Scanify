import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide TorchState;
import 'package:scanify/core/constants/app_helpers.dart' show AppHelpers;
import 'package:scanify/core/enum/qr_source_type.dart' show QrSourceType;
import 'package:scanify/core/models/qrcode_model.dart' show QRCodeModel;
import 'package:scanify/core/services/hive_service.dart';
import 'package:scanify/core/services/scanner_service.dart';
import 'package:scanify/core/services/settings_service.dart';
import 'package:scanify/core/utils/device_util.dart';

class ScannerManager {
  static final instance = ScannerManager._();
  late Set<QRCodeModel> currentModels;

  ScannerManager._() {
    _scanService = ScannerService(
      MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        detectionTimeoutMs: 750,
        autoStart: false,
      ),
    );
    currentModels = {};
  }

  late final ScannerService _scanService;
  final _settingService = SettingsService.instance;
  final _hiveService = HiveService.instance;

  MobileScannerController get controller => _scanService.scannerController;
  ValueNotifier<bool> get detectListener => _scanService.detectState;
  List<List<Offset>>? get detectedCorners => _scanService.detectedCorners;

  bool get isDetected =>
      _scanService.detectState.value && currentModels.isNotEmpty;
  ValueNotifier<bool> get torchState => _scanService.torchState;
  bool get isModelsEmpty => currentModels.isEmpty;

  void addCameraListener(void Function() listener) =>
      _scanService.cameraState.addListener(listener);
  void removeCameraListener(void Function() listener) =>
      _scanService.cameraState.removeListener(listener);

  Future<void> toggleTorch() => _scanService.toggleTorch();
  Future<void> turnTorchOn() => _scanService.turnOnTorch();
  Future<void> turnTorchOff() => _scanService.turnOffTorch();

  bool get isTorchActive => _scanService.torchState.value;
  bool get isCameraActive =>
      _scanService.cameraState.value == CameraState.active;

  bool get autoScan => _settingService.autoScan;

  Future<void> clearDetection() async {
    _scanService.clearDetection();
    currentModels.clear();
  }

  Future<void> startDetection() async {
    await _scanService.start();
  }

  Future<void> stopDetection() async {
    await _scanService.stop();
  }

  Set<QRCodeModel> analyzeFromCameraScan(BarcodeCapture capture) {
    final codes = _scanService.processCapture(
      capture,
      debounceMs: 1000,
      qrOnly: _settingService.scanQrCodeOnly,
      clearTimeMs: _settingService.autoClearDetection.value,
    );
    if (codes.isNotEmpty) {
      if (_settingService.sound) DeviceUtil.playClickSound();
      if (_settingService.haptics) DeviceUtil.vibration();
      currentModels = QRCodeModel.fromBarcodes(codes, QrSourceType.scan);
      return currentModels;
    }
    return {};
  }

  Future<Set<QRCodeModel>> pickAndAnalyzeFromGal() async {
    final paths = await DeviceUtil.pickImagesFromGal();
    final codes = await _scanService.processImages(paths,DeviceUtil.ensureJpegForAnalysis);
    if (codes.isNotEmpty) {
      currentModels = QRCodeModel.fromBarcodes(codes, QrSourceType.picked);
      return currentModels;
    }
    return {};
  }


  Future<bool> saveQrModels([Set<QRCodeModel>? qrData]) async {
    bool isAnySaved = false;
    for (final item in qrData ?? currentModels) {
      if (item.id != null) {
        if (await _hiveService.putIfAbsent(item.id, item)) {
          isAnySaved = true;
        }
      }
    }
    return isAnySaved;
  }

  Future<bool> deleteExpiredSavedModels() async {
    final deleteAfterDays = _settingService.autoDelete.value;
    if (deleteAfterDays <= 0) return false;
    bool isAnyDeleted = false;
    final allItems = _hiveService.getAll<QRCodeModel>();
    for (final item in allItems) {
      if (item.date == null) continue;
      if (AppHelpers.isExpired(item.date!, deleteAfterDays)) {
        if (await _hiveService.delete(item.id)) {
          isAnyDeleted = true;
        }
      }
    }
    return isAnyDeleted;
  }

  Future<bool> deleteSavedQr(QRCodeModel item) async {
    return await _hiveService.delete(item.id);
  }

  List<QRCodeModel> getSavedQrModels(bool Function(QRCodeModel) onFilter) {
    return _hiveService.getAll<QRCodeModel>(onFilter);
  }

  void setListenerToSavedQr(void Function() listener) =>
      _hiveService.listenable.addListener(listener);
  void removeListenerToSavedQr(void Function() listener) =>
      _hiveService.listenable.removeListener(listener);
}
