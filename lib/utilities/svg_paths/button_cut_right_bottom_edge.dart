import 'package:flutter/material.dart';

class ButtonCutRightBottomEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width * 0.01, size.height * 0.01)
      ..cubicTo(size.width * 0.01, size.height * 0.01, size.width, size.height * 0.01, size.width, size.height * 0.01)
      ..cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.85, size.width, size.height * 0.85)
      ..cubicTo(size.width, size.height * 0.85, size.width * 0.92, size.height, size.width * 0.92, size.height)
      ..cubicTo(size.width * 0.92, size.height, size.width * 0.01, size.height, size.width * 0.01, size.height)
      ..cubicTo(size.width * 0.01, size.height, size.width * 0.01, size.height * 0.01, size.width * 0.01, size.height * 0.01)
      ..cubicTo(size.width * 0.01, size.height * 0.01, size.width * 0.01, size.height * 0.01, size.width * 0.01, size.height * 0.01);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
