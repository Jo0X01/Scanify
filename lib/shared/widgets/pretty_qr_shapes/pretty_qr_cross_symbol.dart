import 'dart:ui' show lerpDouble;

import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as a plus/cross (+).
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrCrossSymbol(color: Colors.indigo, thickness: 0.38),
///   ),
/// )
/// ```
class PrettyQrCrossSymbol extends PrettyQrShape {
  const PrettyQrCrossSymbol({
    this.color = const Color(0xFF000000),
    this.size = 0.9,
    this.thickness = 0.38,
  });

  final Color color;

  /// Overall bounding-box size as a fraction of cell width.
  final double size;

  /// Arm thickness as a fraction of cell width.
  final double thickness;

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
      final t = rect.width * thickness / 2;

      // Horizontal bar
      final hBar = Rect.fromLTRB(cx - half, cy - t, cx + half, cy + t);
      // Vertical bar
      final vBar = Rect.fromLTRB(cx - t, cy - half, cx + t, cy + half);

      context.canvas.drawRect(hBar, paint);
      context.canvas.drawRect(vBar, paint);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    if (a is PrettyQrCrossSymbol) {
      return PrettyQrCrossSymbol(
        color: Color.lerp(a.color, color, t)!,
        size: lerpDouble(a.size, size, t)!,
        thickness: lerpDouble(a.thickness, thickness, t)!,
      );
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrCrossSymbol &&
          other.color == color &&
          other.size == size &&
          other.thickness == thickness;

  @override
  int get hashCode => Object.hash(color, size, thickness);
}