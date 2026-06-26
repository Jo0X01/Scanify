import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class CustomPainterBoxWidget extends CustomPainter {
  final bool detected;
  final double scanLinePosition;
  final List<List<Offset>>? allBarcodeCorners;
  final Size? scannerWidgetSize;
  final Size? cameraResolution;
  final double cornerLengthFraction;
  final double strokeWidth;
  final double radius;

  const CustomPainterBoxWidget({
    required this.detected,
    required this.scanLinePosition,
    this.allBarcodeCorners,
    this.scannerWidgetSize,
    this.cameraResolution,
    this.cornerLengthFraction = 0.12,
    this.strokeWidth = 3.5,
    this.radius = 20,
  });

  // ── coordinate mapping ───────────────────────────────────────────────────
  List<Offset>? _toCanvasLocal(Size canvas, List<Offset> corners) {
    if (corners.length != 4) return null;

    final screen = scannerWidgetSize;
    final camera = cameraResolution;
    if (screen == null || camera == null) return null;
    if (camera.width == 0 || camera.height == 0) return null;
    if (screen.width == 0 || screen.height == 0) return null;

    final scale =
        (screen.width / camera.width) > (screen.height / camera.height)
        ? screen.width / camera.width
        : screen.height / camera.height;

    final overflowX = (camera.width * scale - screen.width) / 2;
    final overflowY = (camera.height * scale - screen.height) / 2;

    // ✅ Remove boxOrigin — Center widget already handles centering
    // ✅ Offset corners relative to center of screen → center of canvas
    final centerOffsetX = (screen.width - canvas.width) / 2;
    final centerOffsetY = (screen.height - canvas.height) / 2;

    final mapped = corners
        .map(
          (c) => Offset(
            c.dx * scale - overflowX - centerOffsetX,
            c.dy * scale - overflowY - centerOffsetY,
          ),
        )
        .toList();

    if (mapped.any(
      (o) => o.dx.isNaN || o.dy.isNaN || o.dx.isInfinite || o.dy.isInfinite,
    )) {
      return null;
    }

    return mapped;
  }
  // ── corner bracket ───────────────────────────────────────────────────────

  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    Offset neighbourA,
    Offset neighbourB, {
    required double armLength,
    bool rounded = true,
  }) {
    final dirA = neighbourA - corner;
    final dirB = neighbourB - corner;
    final lenA = dirA.distance;
    final lenB = dirB.distance;

    if (lenA < 1 || lenB < 1) return;

    final arm = armLength.clamp(0.0, lenA / 2).clamp(0.0, lenB / 2);
    if (arm < 1) return;

    final uA = dirA / lenA;
    final uB = dirB / lenB;

    final pA = corner + uA * arm;
    final pB = corner + uB * arm;

    if (!_isValid(pA) || !_isValid(pB)) return;

    final path = Path()..moveTo(pA.dx, pA.dy);

    if (rounded) {
      final r = (arm < radius * 2 ? arm / 2 : radius).clamp(0.5, arm - 0.5);
      final arcA = corner + uA * r;
      final arcB = corner + uB * r;

      if (!_isValid(arcA) || !_isValid(arcB)) return;
      if ((arcA - arcB).distance < 0.01) return;

      final cross = uA.dx * uB.dy - uA.dy * uB.dx;
      path
        ..lineTo(arcA.dx, arcA.dy)
        ..arcToPoint(arcB, radius: Radius.circular(r), clockwise: cross > 0)
        ..lineTo(pB.dx, pB.dy);
    } else {
      path
        ..lineTo(corner.dx, corner.dy)
        ..lineTo(pB.dx, pB.dy);
    }

    canvas.drawPath(path, paint);
  }

  bool _isValid(Offset o) =>
      !o.dx.isNaN && !o.dy.isNaN && !o.dx.isInfinite && !o.dy.isInfinite;

  // ── draw one QR box ──────────────────────────────────────────────────────

  void _drawBox(Canvas canvas, Paint paint, List<Offset> local) {
    final shortSide = _shortSide(local);
    final armLength = shortSide * cornerLengthFraction;

    // mobile_scanner order: [0]=topLeft [1]=topRight [2]=bottomRight [3]=bottomLeft
    _drawCorner(
      canvas,
      paint,
      local[0],
      local[3],
      local[1],
      armLength: armLength,
      rounded: false,
    );
    _drawCorner(
      canvas,
      paint,
      local[1],
      local[0],
      local[2],
      armLength: armLength,
      rounded: false,
    );
    _drawCorner(
      canvas,
      paint,
      local[2],
      local[1],
      local[3],
      armLength: armLength,
      rounded: false,
    );
    _drawCorner(
      canvas,
      paint,
      local[3],
      local[2],
      local[0],
      armLength: armLength,
      rounded: false,
    );
  }

  double _shortSide(List<Offset> corners) {
    final w = (corners[1] - corners[0]).distance;
    final h = (corners[3] - corners[0]).distance;
    return w < h ? w : h;
  }

  // ── fallback idle box ────────────────────────────────────────────────────

  void _paintFallback(Canvas canvas, Size size, Paint paint) {
    final arm = size.shortestSide * cornerLengthFraction;
    final w = size.width;
    final h = size.height;

    _drawCorner(
      canvas,
      paint,
      Offset(0, 0),
      Offset(0, h),
      Offset(w, 0),
      armLength: arm,
    );
    _drawCorner(
      canvas,
      paint,
      Offset(w, 0),
      Offset(0, 0),
      Offset(w, h),
      armLength: arm,
    );
    _drawCorner(
      canvas,
      paint,
      Offset(w, h),
      Offset(w, 0),
      Offset(0, h),
      armLength: arm,
    );
    _drawCorner(
      canvas,
      paint,
      Offset(0, h),
      Offset(w, h),
      Offset(0, 0),
      armLength: arm,
    );
  }

  // ── scan line ────────────────────────────────────────────────────────────

  void _paintScanLine(Canvas canvas, Size size) {
    final scanY = size.height * scanLinePosition;

    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      Paint()
        ..strokeWidth = 2
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primary.withValues(alpha: 0.8),
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(0, scanY, size.width, 2)),
    );

    canvas.drawRect(
      Rect.fromLTWH(0, scanY - 20, size.width, 40),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.0),
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, scanY - 20, size.width, 40)),
    );
  }

  // ── main ─────────────────────────────────────────────────────────────────

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = detected ? AppColors.primary : AppColors.scanBoxIdle
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final allLocal = allBarcodeCorners
        ?.map((corners) => _toCanvasLocal(size, corners))
        .whereType<List<Offset>>()
        .toList();

    if (allLocal != null && allLocal.isNotEmpty) {
      for (final local in allLocal) {
        _drawBox(canvas, paint, local);
      }
    } else {
      _paintFallback(canvas, size, paint);
    }

    _paintScanLine(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainterBoxWidget old) =>
      old.detected != detected ||
      old.scanLinePosition != scanLinePosition ||
      old.allBarcodeCorners != allBarcodeCorners ||
      old.scannerWidgetSize != scannerWidgetSize ||
      old.cameraResolution != cameraResolution;
}
