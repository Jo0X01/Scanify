import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as a regular hexagon.
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrHexagonSymbol(color: Colors.teal),
///   ),
/// )
/// ```
class PrettyQrHexagonSymbol extends PrettyQrShape {
  const PrettyQrHexagonSymbol({
    this.color = const Color(0xFF000000),
    this.size = 0.85,
    this.flat = false,
  });

  final Color color;
  /// Fraction of the cell size each hexagon occupies (0.0–1.0).
  final double size;

  /// If true, one flat side is at the top (flat-top orientation).
  /// If false, a point is at the top (pointy-top orientation).
  final bool flat;

  @override
  void paint(PrettyQrPaintingContext context) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final angleOffset = flat ? 0.0 : math.pi / 6;

    for (final module in context.matrix) {
      if (!module.isDark) continue;

      final rect = module.resolveRect(context);
      final cx = rect.center.dx;
      final cy = rect.center.dy;
      final r = rect.width / 2 * size;

      final path = Path();
      for (int i = 0; i < 6; i++) {
        final angle = (i * math.pi / 3) + angleOffset;
        final x = cx + r * math.cos(angle);
        final y = cy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      context.canvas.drawPath(path, paint);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    if (a is PrettyQrHexagonSymbol) {
      return PrettyQrHexagonSymbol(
        color: Color.lerp(a.color, color, t)!,
        size: lerpDouble(a.size, size, t)!,
        flat: flat,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrHexagonSymbol &&
          other.color == color &&
          other.size == size &&
          other.flat == flat;

  @override
  int get hashCode => Object.hash(color, size, flat);
}