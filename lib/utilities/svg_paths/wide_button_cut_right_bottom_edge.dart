import 'package:flutter/material.dart';

class WideButtonCutRightBottomEdge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
    ..lineTo(0, size.height * 0.01)
    ..cubicTo(0, size.height * 0.01, size.width, size.height * 0.01, size.width, size.height * 0.01)
    ..cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.86, size.width, size.height * 0.86)
    ..cubicTo(size.width, size.height * 0.86, size.width * 0.96, size.height, size.width * 0.96, size.height)
    ..cubicTo(size.width * 0.96, size.height, 0, size.height, 0, size.height)
    ..cubicTo(0, size.height, 0, size.height * 0.01, 0, size.height * 0.01)
    ..cubicTo(0, size.height * 0.01, 0, size.height * 0.01, 0, size.height * 0.01);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
