import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show Offset;
import 'package:mobile_scanner/mobile_scanner.dart';

enum CameraState { active, inactive }

class ScannerService {
  ScannerService(this.scannerController) : currentBarCode = {};

  final MobileScannerController scannerController;
  Set<Barcode> currentBarCode;
  Timer? _clearTimer;
  DateTime? _lastCaptureTime;

  final cameraState = ValueNotifier(CameraState.inactive);
  final torchState = ValueNotifier(false);
  final detectState = ValueNotifier(false);
  final Set<BarcodeFormat> _formats = {};

  List<List<Offset>>? get detectedCorners =>
      currentBarCode.map((ele) => ele.corners).toList();

  bool get isBarcodeEmpty => currentBarCode.isEmpty;

  Future<void> restartController() async {
    await stop();
    await start();
  }

  Future<void> start() async {
    if (cameraState.value == CameraState.inactive) {
      await scannerController.start().then((_) {
        cameraState.value = CameraState.active;
      });
    }
  }

  Future<void> stop() async {
    if (cameraState.value == CameraState.active) {
      await scannerController.stop().then((_) {
        cameraState.value = CameraState.inactive;
      });
    }
  }

  Future<void> dispose() async {
    await scannerController.dispose();
    detectState.dispose();
    cameraState.dispose();
    torchState.dispose();
  }

  // Torch Workers
  Future<void> toggleTorch() async {
    if (torchState.value) {
      await turnOffTorch();
    } else {
      await turnOnTorch();
    }
  }

  Future<void> turnOffTorch() async {
    if (torchState.value) {
      await scannerController.toggleTorch().then((_) {
        torchState.value = false;
      });
    }
  }

  Future<void> turnOnTorch() async {
    if (!torchState.value) {
      await scannerController.toggleTorch().then((_) {
        torchState.value = true;
      });
    }
  }

  // Barcode Workers
  Set<Barcode> processCapture(
    BarcodeCapture capture, {
    required bool qrOnly,
    required int clearTimeMs,
    int limit = -1,
    int debounceMs = 500,
  }) {
    if (!_isReadyToCapture(debounceMs: debounceMs)) return currentBarCode;
    _setFilters([BarcodeFormat.qrCode], qrOnly);
    if (_isAlreadyCaptured(capture)) {
      if (_updateCorners(capture)) {
        _refreshDetection();
      }
    } else {
      _cancelClearTimer();
      _handleCapture(capture, limit: limit);
      _startClearTimer(clearTimeMs);
    }
    return currentBarCode;
  }

  Future<Set<Barcode>> processImages(
    List<String> imagesPath, [
    Future<String> Function(String)? encodeMethod,
  ]) async {
    Set<Barcode> codes = {};
    for (final image in imagesPath) {
      final models = await scannerController.analyzeImage(
        encodeMethod != null ? (await encodeMethod(image)) : image,
        formats: _formats.toList(),
      );
      if (models == null) continue;
      final code = _filterBarcode(models);
      if (code.isEmpty) continue;
      codes.addAll(code);
    }
    currentBarCode = codes;
    return currentBarCode;
  }

  bool _isAlreadyCaptured(BarcodeCapture capture) {
    if (isBarcodeEmpty) return false;
    final codes = _filterBarcode(capture);
    if (codes.isEmpty) return false;
    if (currentBarCode.length != codes.length) return false;
    return codes.every(
      (barcode) =>
          currentBarCode.any((current) => current.rawValue == barcode.rawValue),
    );
  }

  bool _isReadyToCapture({int debounceMs = 500}) {
    final now = DateTime.now();
    if (_lastCaptureTime != null &&
        now.difference(_lastCaptureTime!).inMilliseconds < debounceMs) {
      return false;
    }
    _lastCaptureTime = now;
    return true;
  }

  void _handleCapture(BarcodeCapture capture, {int limit = 3}) {
    currentBarCode = _filterBarcode(capture, limit).toSet();
    if (currentBarCode.isNotEmpty) {
      detectState.value = true;
    }
  }

  bool _updateCorners(BarcodeCapture capture) {
    final codes = _filterBarcode(capture).toSet();
    if (codes.isEmpty || _sameAllCorners(currentBarCode, codes)) {
      return false;
    }
    currentBarCode = codes;
    return true;
  }

  List<Barcode> _filterBarcode(BarcodeCapture capture, [int limit = -1]) {
    final barCodes = capture.barcodes.where((b) {
      final hasValue = b.rawValue != null && b.rawValue!.isNotEmpty;
      final isCorrectFormat = _formats.isEmpty || _formats.contains(b.format);
      return hasValue && isCorrectFormat;
    }).toList();
    if (limit == -1 || limit >= barCodes.length) {
      return barCodes;
    }
    return barCodes.sublist(0, limit);
  }

  void _setFilters(List<BarcodeFormat> filters, bool active) {
    for (final filter in filters) {
      if (active) {
        if (!_formats.contains(filter)) {
          _formats.add(filter);
        }
      } else {
        if (_formats.contains(filter)) {
          _formats.remove(filter);
        }
      }
    }
  }

  void _startClearTimer(int clearDelay) {
    _clearTimer?.cancel();
    final duration = Duration(
      seconds: clearDelay,
      milliseconds: scannerController.detectionTimeoutMs,
    );
    _clearTimer = Timer(duration, clearDetection);
  }

  void _cancelClearTimer() => _clearTimer?.cancel();

  void clearDetection() {
    detectState.value = false;
    currentBarCode = {};
  }

  void _refreshDetection() {
    if (detectState.value == true) {
      detectState.value = false;
      detectState.value = true;
      return;
    }
    if (detectState.value == false) {
      detectState.value = true;
      detectState.value = false;
      return;
    }
  }
}

bool _sameCorners(List<Offset> a, List<Offset> b, {double tolerance = 25}) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if ((a[i] - b[i]).distance > tolerance) return false;
  }
  return true;
}

bool _sameAllCorners(Set<Barcode> a, Set<Barcode> b) {
  if (a.isEmpty || b.isEmpty) return false;
  if (a.length != b.length) return false;
  final a1 = a.toList();
  final b1 = b.toList();
  for (int i = 0; i < a1.length; i++) {
    if (!_sameCorners(a1[i].corners, b1[i].corners)) {
      return false;
    }
  }
  return true;
}
