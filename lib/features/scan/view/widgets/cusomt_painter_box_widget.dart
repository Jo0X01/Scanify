import 'package:flutter/material.dart';

class CusomtPainterBoxWidget extends CustomPainter {
  final bool detected;

  CusomtPainterBoxWidget({required this.detected});

  final double cornerLength = 25;
  final double strokeWidth = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = detected ? Colors.greenAccent : Colors.white
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    _drawCorners(canvas, size, paint);
  }

  void _drawCorners(Canvas canvas, Size size, Paint paint) {
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);

    canvas.drawLine(
      Offset(size.width - cornerLength, 0),
      Offset(size.width, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - cornerLength),
      Offset(0, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width - cornerLength, size.height),
      Offset(size.width, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - cornerLength),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CusomtPainterBoxWidget oldDelegate) {
    return oldDelegate.detected != detected;
  }
}
