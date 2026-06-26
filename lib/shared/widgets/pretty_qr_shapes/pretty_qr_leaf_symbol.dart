import 'dart:ui' show lerpDouble;

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as a leaf shape —
/// a square whose corners each curve in a different direction,
/// creating an organic, petal-like look.
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrLeafSymbol(color: Colors.green),
///   ),
/// )
/// ```
class PrettyQrLeafSymbol extends PrettyQrShape {
  const PrettyQrLeafSymbol({
    this.color = const Color(0xFF000000),
    this.size = 0.85,
    this.curve = 0.4,
  });

  final Color color;

  /// Fraction of the cell size the leaf occupies (0.0–1.0).
  final double size;

  /// How much the sides bow inward/outward.
  /// Positive = outward (plump), negative = inward (pinched).
  final double curve;

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
      final r = rect.width / 2 * size;
      final c = r * curve;

      // A "leaf": each side is a quadratic bezier that bows outward.
      final path = Path()
        ..moveTo(cx, cy - r)                            // top
        ..quadraticBezierTo(cx + r + c, cy - r, cx + r, cy) // top→right
        ..quadraticBezierTo(cx + r, cy + r + c, cx, cy + r) // right→bottom
        ..quadraticBezierTo(cx - r - c, cy + r, cx - r, cy) // bottom→left
        ..quadraticBezierTo(cx - r, cy - r - c, cx, cy - r) // left→top
        ..close();

      context.canvas.drawPath(path, paint);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    if (a is PrettyQrLeafSymbol) {
      return PrettyQrLeafSymbol(
        color: Color.lerp(a.color, color, t)!,
        size: lerpDouble(a.size, size, t)!,
        curve: lerpDouble(a.curve, curve, t)!,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrLeafSymbol &&
          other.color == color &&
          other.size == size &&
          other.curve == curve;

  @override
  int get hashCode => Object.hash(color, size, curve);
}