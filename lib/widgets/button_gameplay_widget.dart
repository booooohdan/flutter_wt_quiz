import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/gameplay_button_model.dart';
import '../utilities/constants.dart';

import '../utilities/svg_paths/wide_button_cut_bottom_edges.dart';

class ButtonGameplayWidget extends StatelessWidget {
  const ButtonGameplayWidget({
    Key? key,
    required this.context,
    required this.onTap,
    required this.model,
  }) : super(key: key);

  final BuildContext context;
  final Function()? onTap;
  final GameplayButtonModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ClipPath(
        clipper: WideButtonCutBottomEdges(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/buttons/wide_button_cut_bottom_edges.png'),
                    fit: BoxFit.fill)),
            child: Material(
              color: model.isGreenBlink ? greenButtonColor : Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.answerText,
                      style: GoogleFonts.oxygen(
                          fontSize: 16,
                          color: model.isGreenBlink ? Colors.black : Colors.white,
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
