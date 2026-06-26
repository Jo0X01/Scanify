import 'dart:ui' show lerpDouble;

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as a heart ♥.
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrHeartSymbol(color: Colors.red),
///   ),
/// )
/// ```
class PrettyQrHeartSymbol extends PrettyQrShape {
  const PrettyQrHeartSymbol({
    this.color = const Color(0xFFE53935),
    this.size = 1.2,
  });

  final Color color;
  /// Fraction of the cell size each heart occupies (0.0–1.0).
  final double size;

  @override
  void paint(PrettyQrPaintingContext context) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final module in context.matrix) {
      if (!module.isDark) continue;

      final rect = module.resolveRect(context);
      final s = rect.width * size;
      final cx = rect.center.dx;
      // shift center slightly upward so the heart looks visually centered
      final cy = rect.center.dy + s * 0.05;

      // Heart drawn with two cubic bezier curves
      // Top-left lobe, top-right lobe, bottom tip
      final path = Path()
        ..moveTo(cx, cy - s * 0.25)
        // Left lobe
        ..cubicTo(
          cx - s * 0.5, cy - s * 0.6,
          cx - s * 0.55, cy + s * 0.1,
          cx, cy + s * 0.45,
        )
        // Right lobe
        ..cubicTo(
          cx + s * 0.55, cy + s * 0.1,
          cx + s * 0.5, cy - s * 0.6,
          cx, cy - s * 0.25,
        )
        ..close();

      context.canvas.drawPath(path, paint);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    if (a is PrettyQrHeartSymbol) {
      return PrettyQrHeartSymbol(
        color: Color.lerp(a.color, color, t)!,
        size: lerpDouble(a.size, size, t)!,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrHeartSymbol &&
          other.color == color &&
          other.size == size;

  @override
  int get hashCode => Object.hash(color, size);
}