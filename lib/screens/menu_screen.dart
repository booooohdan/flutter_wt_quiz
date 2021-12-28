import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_bottom_edges.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/main_menu.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'WT QUIZ',
                      style: GoogleFonts.chakraPetch(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Game modes:',
                        style: GoogleFonts.chakraPetch(
                            fontSize: 16,
                            color: greyTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      //TODO: Change mocked routes to correct
                      _buildMenuButton('CLASSIC', '/levels'),
                      _buildMenuButton('HARDCORE', '/levels'),
                      _buildMenuButton('TRAINING', '/levels'),
                      GestureDetector(
                        //TODO: Change mocked routes to correct
                        onTap: () => Navigator.pushNamed(context, '/login'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'FEEDBACK',
                              style: GoogleFonts.oxygen(
                                  fontSize: 16,
                                  color: greyTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(
                              'assets/icons/right_arrow.svg',
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildMenuButton(String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ClipPath(
        clipper: ButtonCutBottomEdges(),
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
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, route),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.oxygen(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      //   child: Text(
                      //     '4/100',
                      //     style: GoogleFonts.oxygen(
                      //       fontSize: 16,
                      //       color: greyTextColor,
                      //     ),
                      //   ),
                      // ),
                      SvgPicture.asset(
                        'assets/icons/right_arrow.svg',
                        height: 16,
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
