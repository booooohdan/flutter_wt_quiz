import 'package:flutter/material.dart';

class ButtonCutLeftBottomEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
    ..lineTo(size.width, size.height * 0.01)
    ..cubicTo(size.width, size.height * 0.01, size.width * 0.01, size.height * 0.01, size.width * 0.01, size.height * 0.01)
    ..cubicTo(size.width * 0.01, size.height * 0.01, size.width * 0.01, size.height * 0.85, size.width * 0.01, size.height * 0.85)
    ..cubicTo(size.width * 0.01, size.height * 0.85, size.width * 0.09, size.height, size.width * 0.09, size.height)
    ..cubicTo(size.width * 0.09, size.height, size.width, size.height, size.width, size.height)
    ..cubicTo(size.width, size.height, size.width, size.height * 0.01, size.width, size.height * 0.01)
    ..cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.01, size.width, size.height * 0.01);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
