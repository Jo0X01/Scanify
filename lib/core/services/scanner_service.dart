import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show Offset;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_scanner_app/core/enum/auto_clear_detection_delay.dart';
import 'package:qrcode_scanner_app/core/enum/qr_source_type.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/device_util.dart';

class ScannerService {
  ScannerService._();
  static final ScannerService instance = ScannerService._();

  final ValueNotifier<bool> detectedNotifier = ValueNotifier<bool>(false);
  late final Set<BarcodeFormat> _formats = {};

  MobileScannerController? _scannerController;
  List<QRCodeModel>? currentModels;
  List<Barcode>? currentBarCode;
  Timer? _clearTimer;
  bool _isControllerStarted = true;

  bool get isDetected =>
      detectedNotifier.value && (currentModels?.isNotEmpty ?? false);
  bool get isModelsEmpty => currentModels?.isEmpty ?? true;
  bool get isBarcodeEmpty => currentBarCode?.isEmpty ?? true;

  Future<void> toggleTorch() => _scannerController!.toggleTorch();
  MobileScannerController? getCurrentController() => _scannerController;

  void setController(MobileScannerController controller) {
    _scannerController?.dispose();
    _scannerController = controller;
  }

  List<QRCodeModel>? handleCapture(BarcodeCapture capture, {int limit = 3}) {
    final code = _getBarcode(capture, limit);
    currentBarCode = code;
    if (code.isEmpty) return null;
    detectedNotifier.value = true;
    currentModels = QRCodeModel.fromBarcodes(code, QrSourceType.scan);
    return currentModels;
  }

  Future<List<QRCodeModel>?> pickFromGallery() async {
    final images = await DeviceUtil.pickImagesFromGal();
    if (images.isEmpty) return null;
    List<Barcode> codes = [];
    for (final image in images) {
      final models = await _scannerController?.analyzeImage(
        image.path,
        formats: _formats.toList(),
      );
      if (models == null) continue;
      final code = _getBarcode(models);
      if (code.isEmpty) continue;
      codes.addAll(code);
    }
    currentBarCode = codes;
    if (codes.isEmpty) return null;
    currentModels = QRCodeModel.fromBarcodes(codes, QrSourceType.picked);
    return currentModels;
  }

  Future<void> restartController() async {
    await stopController();
    await startController();
  }

  Future<void> stopController() async {
    if (_isControllerStarted) {
      await _scannerController?.stop().then(
        (val) => _isControllerStarted = false,
      );
    }
  }

  Future<void> startController() async {
    if (!_isControllerStarted) {
      await _scannerController?.start().then(
        (val) => _isControllerStarted = true,
      );
    }
  }

  void setScanQrOnly(bool value){
    if(value){
      _formats.add(BarcodeFormat.qrCode);
    }else{
      _formats.remove(BarcodeFormat.qrCode);
    }
  }
  List<List<Offset>>? get detectedCorners =>
      isDetected ? currentBarCode?.map((ele) => ele.corners).toList() : null;

  void startClearTimer(AutoClearDetectionDelay clearDelay) {
    _clearTimer?.cancel();
    _clearTimer = Timer(
      Duration(
        seconds: clearDelay.value,
        milliseconds: _scannerController?.detectionTimeoutMs ?? 0,
      ),
      clearDetection,
    );
  }

  void cancelClearTimer() => _clearTimer?.cancel();

  void enableDetection() => detectedNotifier.value = true;
  void disableDetection() => detectedNotifier.value = false;
  void toggleDetection() => detectedNotifier.value = !detectedNotifier.value;
  void refreshDetection() {
    detectedNotifier.value = !detectedNotifier.value;
    detectedNotifier.value = !detectedNotifier.value;
  }

  void clearDetection() {
    detectedNotifier.value = false;
    currentModels = null;
    currentBarCode = null;
  }

  Future<void> dispose() async {
    await _scannerController?.dispose();
    detectedNotifier.dispose();
  }

  bool isAlreadyCaptured(BarcodeCapture capture) {
    if (isBarcodeEmpty) return false;
    final codes = _getBarcode(capture);
    if (codes.isEmpty) return false;
    if (currentBarCode!.length != codes.length) return false;
    return codes.every(
      (barcode) => currentBarCode!.any(
        (current) => current.rawValue == barcode.rawValue,
      ),
    );
  }

  bool updateCorners(BarcodeCapture capture) {
    final codes = _getBarcode(capture);
    if (codes.isEmpty || _sameAllCorners(currentBarCode, codes)) {
      return false;
    }
    currentBarCode = codes;
    return true;
  }

  List<Barcode> _getBarcode(BarcodeCapture capture, [int limit = -1]) {
    final barCodes = capture.barcodes.where(_filterBarcode).toList();
    if (limit == -1 || limit >= barCodes.length) {
      return barCodes;
    }
    return barCodes.sublist(0, limit);
  }

  bool _filterBarcode(Barcode b) {
    final hasValue = b.rawValue != null && b.rawValue!.isNotEmpty;
    final isCorrectFormat = _formats.isEmpty || _formats.contains(b.format);
    return hasValue && isCorrectFormat;
  }

  bool _sameCorners(List<Offset> a, List<Offset> b, {double tolerance = 25}) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if ((a[i] - b[i]).distance > tolerance) return false;
    }
    return true;
  }

  bool _sameAllCorners(List<Barcode>? a, List<Barcode>? b) {
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!_sameCorners(a[i].corners, b[i].corners)) return false;
    }
    return true;
  }
}
