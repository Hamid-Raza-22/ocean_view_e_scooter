import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Arrow color
      ..strokeWidth = 3.0 // Border thickness
      ..style = PaintingStyle.stroke; // Set to stroke for borders

    final path = Path();

    // Drawing a simple arrow
    path.moveTo(0, size.height / 2); // Start at the left middle
    path.lineTo(size.width, size.height / 2); // Draw horizontal line
    path.moveTo(size.width - 5, size.height / 2 - 5); // Top part of arrowhead
    path.lineTo(size.width, size.height / 2); // Arrowhead right point
    path.lineTo(size.width - 5, size.height / 2 + 5); // Bottom part of arrowhead

    canvas.drawPath(path, paint); // Draw the arrow
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}