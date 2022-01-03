import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_regular.dart';
import '../widgets/button_gameplay_wide.dart';
import '../widgets/button_square.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/finish_success.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegular(
                  context: context,
                  isBackArrowShown: true,
                  centerLabel: 'About',
                  rightLabel: '',
                  icon: '',
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage('assets/icons/icon.png'),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Version 2.0.0',
                        style: chakra16grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 50),
                        child: Text(
                          'WT Quiz is a trivia game with vehicles from the game War Thunder. All images and description have been taken from wiki.warthunder.com',
                          style: oxygen10white,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonGameplayWide(
                        context: context,
                        icon: 'assets/icons/github.svg',
                        title: 'GitHub',
                        backgroundColor: Colors.green,
                        textColor: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                  context: context,
                                  clipper: ButtonCutLeftBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_left_bottom_edge.png',
                                  leadingIcon: 'assets/icons/star.svg',
                                  text: 'RATE APP',
                                  count: ''),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                  context: context,
                                  clipper: ButtonNoCut(),
                                  backgroundImage:
                                  'assets/buttons/button_no_cut.png',
                                  leadingIcon: 'assets/icons/share.svg',
                                  text: 'SHARE',
                                  count: ''),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ButtonSquare(
                                  context: context,
                                  clipper: ButtonCutRightBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_right_bottom_edge.png',
                                  leadingIcon: 'assets/icons/gmail.svg',
                                  text: 'REPORT A BUG',
                                  count: ''),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            //TODO: Set correct command for Reset
                            //onTap: () => Navigator.pushNamed(context, '/about'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/reset.svg',
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'RESET',
                                  style: oxygen10white,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            //TODO: Set correct command for Privacy
                            //onTap: () => Navigator.pushNamed(context, '/about'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/privacy.svg',
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'PRIVACY',
                                  style: oxygen10white,
                                ),
                              ],
                            ),
                          )
                        ],
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
}
