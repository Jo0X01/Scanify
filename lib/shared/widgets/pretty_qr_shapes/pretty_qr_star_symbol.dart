import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';


/// A QR symbol that renders each dark module as a 5-pointed star.
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrStarSymbol(color: Colors.amber),
///   ),
/// )
/// ```
class PrettyQrStarSymbol extends PrettyQrShape {
  const PrettyQrStarSymbol({
    this.color = const Color(0xFF000000),
    this.outerRadius = 0.6,
    this.innerRadius = 0.25,
    this.points = 5
  });

  final Color color;
  /// Outer tip radius as a fraction of cell width.
  final double outerRadius;

  /// Inner (valley) radius as a fraction of cell width.
  final double innerRadius;

  /// Number of star points (5 or 6 look best).
  final int points;

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
      final outer = rect.width * outerRadius;
      final inner = rect.width * innerRadius;

      final path = Path();
      for (int i = 0; i < points * 2; i++) {
        final angle = (i * math.pi / points) - math.pi / 2;
        final r = i.isEven ? outer : inner;
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
    if (a is PrettyQrStarSymbol) {
      return PrettyQrStarSymbol(
        color: Color.lerp(a.color, color, t)!,
        outerRadius: lerpDouble(a.outerRadius, outerRadius, t)!,
        innerRadius: lerpDouble(a.innerRadius, innerRadius, t)!,
        points: points,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrStarSymbol &&
          other.color == color &&
          other.outerRadius == outerRadius &&
          other.innerRadius == innerRadius &&
          other.points == points;

  @override
  int get hashCode => Object.hash(color, outerRadius, innerRadius, points);
}