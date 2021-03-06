import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/svg_paths/wide_button_cut_bottom_edges.dart';

class ButtonWideWidget extends StatelessWidget {
  const ButtonWideWidget({
    Key? key,
    required this.context,
    required this.icon,
    required this.title,
    required this.onTap,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.white,
  }) : super(key: key);

  final BuildContext context;
  final String icon;
  final String title;
  final Function()? onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ClipPath(
        clipper: WideButtonCutBottomEdges(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            width: 500,
            height: height / 12,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/buttons/wide_button_cut_bottom_edges.png'),
                    fit: BoxFit.fill)),
            child: Material(
              color: backgroundColor,
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon.isNotEmpty
                        ? Row(
                            children: [
                              SvgPicture.asset(
                                icon,
                                height: 24,
                              ),
                              const SizedBox(width: 10)
                            ],
                          )
                        : Container(),
                    Text(
                      title,
                      style: GoogleFonts.oxygen(
                          fontSize: 16,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
