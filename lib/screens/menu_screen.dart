import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';
import '../widgets/button_menu_wide.dart';

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
                      style: chakra48white,
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
                        style: chakra16grey,
                      ),
                      //TODO: Change mocked routes to correct
                      ButtonMenuWide(
                        context: context,
                        title: 'CLASSIC',
                        details: '',
                        route: '/levels',
                      ),
                      ButtonMenuWide(
                        context: context,
                        title: 'HARDCORE',
                        details: '',
                        route: '/levels',
                      ),
                      ButtonMenuWide(
                        context: context,
                        title: 'TRAINING',
                        details: '',
                        route: '/levels',
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/about'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'FEEDBACK',
                              style: oxygen16grey,
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
}
