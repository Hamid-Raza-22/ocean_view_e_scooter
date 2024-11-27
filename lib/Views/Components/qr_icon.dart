import 'package:flutter/material.dart';

class QrIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const QrIcon({
    super.key,
    this.size = 80,
    this.color = Colors.white,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(opacity),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.qr_code_2,
          size: size * 0.625,
          color: Colors.white,
        ),
      ),
    );
  }
}
