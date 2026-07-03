import 'package:flutter/painting.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// A QR symbol that renders each dark module as an emoji glyph
/// (e.g. 🍃, 🌸, ⭐) instead of a plain shape.
///
/// Usage:
/// ```dart
/// PrettyQrView.data(
///   data: 'https://example.com',
///   decoration: PrettyQrDecoration(
///     shape: PrettyQrEmojiSymbol(emoji: '🍃'),
///   ),
/// )
/// ```
class PrettyQrEmojiSymbol extends PrettyQrShape {
  const PrettyQrEmojiSymbol({
    this.color = const Color(0xFF000000),
    this.emoji = '🍃',
    this.scale = 1.0,
  });

  final Color color;
  /// The emoji (or any short text glyph) drawn into each dark module.
  final String emoji;

  /// Multiplier on the cell size used to pick the font size.
  /// 1.0 ≈ glyph fills the module; increase to overflow slightly into
  /// neighboring cells for a denser look.
  final double scale;

  @override
  void paint(PrettyQrPaintingContext context) {
    for (final module in context.matrix) {
      if (!module.isDark) continue;

      final rect = module.resolveRect(context);

      final textPainter = TextPainter(
        text: TextSpan(
          text: emoji,
          style: TextStyle(
            fontSize: rect.height * scale,
            color: color, // ignored by most color-emoji fonts, kept for
                          // symbol/outline fonts that do respect it
            height: 1.0,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(
        rect.center.dx - textPainter.width / 2,
        rect.center.dy - textPainter.height / 2,
      );

      textPainter.paint(context.canvas, offset);
    }
  }

  @override
  PrettyQrShape lerpFrom(PrettyQrShape? a, double t) {
    // Glyphs don't have a sensible "in-between" shape, so just snap
    // to whichever symbol is closer during an animated transition.
    if (a is PrettyQrEmojiSymbol) {
      return t < 0.5 ? a : this;
    }
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrettyQrEmojiSymbol &&
          other.color == color &&
          other.emoji == emoji &&
          other.scale == scale;

  @override
  int get hashCode => Object.hash(color, emoji, scale);
}