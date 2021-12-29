import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSquare extends StatelessWidget {
  const ButtonSquare({
    Key? key,
    required this.context,
    required this.clipper,
    required this.backgroundImage,
    required this.leadingIcon,
    required this.text,
    required this.count,
  }) : super(key: key);

  final BuildContext context;
  final CustomClipper<Path> clipper;
  final String backgroundImage;
  final String leadingIcon;
  final String text;
  final String count;

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
            color: Colors.transparent,
            child: InkWell(
              //TODO: Change onTap to correct
              onTap: () {},
              child: Stack(children: [
                Positioned(
                  top: 5,
                  right: 10,
                  child: Text(
                    count,
                    style: GoogleFonts.chakraPetch(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
                        style: GoogleFonts.oxygen(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
