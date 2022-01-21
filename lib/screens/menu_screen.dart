import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilities/constants.dart';
import '../widgets/button_menu_wide_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  Future<void> initPlugin() async {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }

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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WAR THUNDER',
                          style: chakra22whiteBold,
                        ),
                        Text(
                          'QUIZ',
                          style: GoogleFonts.chakraPetch(
                              fontSize: 72,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Game modes:',
                          style: chakra18greyBold,
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: ButtonMenuWideWidget(
                          context: context,
                          title: 'CLASSIC',
                          details: '',
                          route: '/levels',
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: ButtonMenuWideWidget(
                          context: context,
                          title: 'HARDCORE',
                          details: '',
                          route: '/levels',
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: ButtonMenuWideWidget(
                          context: context,
                          title: 'TRAINING',
                          details: '',
                          route: '/levels',
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/feedback'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'FEEDBACK',
                                style: oxygen18greyBold,
                              ),
                              const SizedBox(width: 20),
                              SvgPicture.asset(
                                'assets/icons/right_arrow.svg',
                                height: 20,
                              ),
                            ],
                          ),
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
