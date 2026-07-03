import 'dart:ui' show lerpDouble;

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as a diamond (rotated square).
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrDiamondSymbol(color: Colors.black),
///   ),
/// )
/// ```
class PrettyQrDiamondSymbol extends PrettyQrShape {
  const PrettyQrDiamondSymbol({
    this.color = const Color(0xFF000000),
    this.size = 1.5,
  });

  final double size;
  final Color color;

  @override
  void paint(PrettyQrPaintingContext context) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final module in context.matrix) {
      if (!module.isDark) continue;
      
      final rect = module.resolveRect(context);
      final cx = rect.center.dx;
      final cy = rect.center.dy;
      final half = rect.width / 2 * size;

      final path = Path()
        ..moveTo(cx, cy - half)
        ..lineTo(cx + half, cy)
        ..lineTo(cx, cy + half)
        ..lineTo(cx - half, cy)
        ..close();

      context.canvas.drawPath(path, paint);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    if (a is PrettyQrDiamondSymbol) {
      return PrettyQrDiamondSymbol(
        color: Color.lerp(a.color, color, t)!,
        size: lerpDouble(a.size, size, t)!,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrDiamondSymbol &&
          other.color == color &&
          other.size == size;

  @override
  int get hashCode => Object.hash(color, size);
}