import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/svg_paths/wide_button_cut_right_bottom_edge.dart';

class ListItemLevel extends StatelessWidget {
  const ListItemLevel({
    Key? key,
    required this.context,
    required this.number,
    required this.questionCount,
  }) : super(key: key);

  final BuildContext context;
  final int? number;
  final int? questionCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ClipPath(
        clipper: WideButtonCutRightBottomEdge(),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/buttons/wide_button_cut_right_bottom_edge.png'),
                  fit: BoxFit.fill),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                //TODO: Change onTap to correct
                onTap: () => Navigator.pushNamed(context, '/gameplay'),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Level $number',
                          style: GoogleFonts.oxygen(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '$questionCount/10',
                        style: GoogleFonts.oxygen(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
