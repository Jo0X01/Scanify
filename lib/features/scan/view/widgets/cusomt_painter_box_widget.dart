import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

class CusomtPainterBoxWidget extends CustomPainter {
  final bool detected;
  final double scanLinePosition; // 0.0 to 1.0

  CusomtPainterBoxWidget({
    required this.detected,
    required this.scanLinePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final color = detected ? AppColors.primary : AppColors.scanBoxIdle;
    final cornerLength = size.width * 0.12;
    final strokeWidth = 3.5;
    final radius = 12.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // ─── Top Left ───────────────────────
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, radius)
        ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
        ..lineTo(cornerLength, 0),
      paint,
    );

    // ─── Top Right ──────────────────────
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, 0)
        ..lineTo(size.width - radius, 0)
        ..arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        )
        ..lineTo(size.width, cornerLength),
      paint,
    );

    // ─── Bottom Left ────────────────────
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - cornerLength)
        ..lineTo(0, size.height - radius)
        ..arcToPoint(
          Offset(radius, size.height),
          radius: Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(cornerLength, size.height),
      paint,
    );

    // ─── Bottom Right ───────────────────
    canvas.drawPath(
      Path()
        ..moveTo(size.width - cornerLength, size.height)
        ..lineTo(size.width - radius, size.height)
        ..arcToPoint(
          Offset(size.width, size.height - radius),
          radius: Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(size.width, size.height - cornerLength),
      paint,
    );

    // ─── Scan Line ──────────────────────
    final scanY = size.height * scanLinePosition;
    final scanLinePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.primary.withOpacity(0.8),
          AppColors.primary,
          AppColors.primary.withOpacity(0.8),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, scanY, size.width, 2));

    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      scanLinePaint..strokeWidth = 2,
    );

    // ─── Scan Line Glow ─────────────────
    final glowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withOpacity(0.0),
          AppColors.primary.withOpacity(0.08),
          AppColors.primary.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, scanY - 20, size.width, 40));

    canvas.drawRect(Rect.fromLTWH(0, scanY - 20, size.width, 40), glowPaint);
  }

  @override
  bool shouldRepaint(CusomtPainterBoxWidget old) =>
      old.detected != detected || old.scanLinePosition != scanLinePosition;
}
