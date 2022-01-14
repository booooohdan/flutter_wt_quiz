import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class ButtonSquareWidget extends StatelessWidget {
  const ButtonSquareWidget({
    Key? key,
    required this.context,
    required this.clipper,
    required this.backgroundImage,
    required this.leadingIcon,
    required this.text,
    required this.count,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final CustomClipper<Path> clipper;
  final String backgroundImage;
  final String leadingIcon;
  final String text;
  final String count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: clipper,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.fill)),
          child: Material(
            color: count == '0' ? greyTransparentColor : Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Stack(children: [
                Positioned(
                  top: 5,
                  right: 10,
                  child: Text(
                    count,
                    style: chakra14whiteBold,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        leadingIcon,
                        height: 20,
                      ),
                      Text(
                        text,
                        style: oxygen10whiteBold,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
