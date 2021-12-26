import 'package:flutter/cupertino.dart';

class ButtonCutBottomEdges extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path()
    ..lineTo(0, size.height * 0.01)
    ..cubicTo(0, size.height * 0.01, size.width, size.height * 0.01, size.width, size.height * 0.01)
    ..cubicTo(size.width, size.height * 0.01, size.width, size.height * 0.81, size.width, size.height * 0.81)
    ..cubicTo(size.width, size.height * 0.81, size.width * 0.97, size.height, size.width * 0.97, size.height)
    ..cubicTo(size.width * 0.97, size.height, size.width * 0.03, size.height, size.width * 0.03, size.height)
    ..cubicTo(size.width * 0.03, size.height, 0, size.height * 0.81, 0, size.height * 0.81)
    ..cubicTo(0, size.height * 0.81, 0, size.height * 0.01, 0, size.height * 0.01)
    ..cubicTo(0, size.height * 0.01, 0, size.height * 0.01, 0, size.height * 0.01);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
