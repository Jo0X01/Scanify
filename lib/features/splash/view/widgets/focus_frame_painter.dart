
import 'package:flutter/material.dart';

class FocusFramePainter extends CustomPainter {
  Color color;

  FocusFramePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const len = 22.0;

    // top-left
    canvas.drawLine(Offset(0, len), Offset(0, 0), p);
    canvas.drawLine(Offset(0, 0), Offset(len, 0), p);

    // top-right
    canvas.drawLine(Offset(size.width - len, 0), Offset(size.width, 0), p);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), p);

    // bottom-left
    canvas.drawLine(Offset(0, size.height - len), Offset(0, size.height), p);
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), p);

    // bottom-right
    canvas.drawLine(
      Offset(size.width - len, size.height),
      Offset(size.width, size.height),
      p,
    );
    canvas.drawLine(
      Offset(size.width, size.height - len),
      Offset(size.width, size.height),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
