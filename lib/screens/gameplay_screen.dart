import 'package:flutter/material.dart';

import '../models/level.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_gameplay.dart';
import '../widgets/button_gameplay_wide.dart';
import '../widgets/button_square.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/gameplay.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarGameplay(context: context),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '59 s',
                        style: oxygen14white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          backgroundColor: greyTextColor,
                          value: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Image(
                    image: AssetImage('assets/planes/a2d.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ButtonSquare(
                            context: context,
                            clipper: ButtonCutLeftBottomEdge(),
                            backgroundImage:
                                'assets/buttons/button_cut_left_bottom_edge.png',
                            leadingIcon: 'assets/icons/fifty_fifty.svg',
                            text: '50/50',
                            count: '1',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: ButtonSquare(
                            context: context,
                            clipper: ButtonNoCut(),
                            backgroundImage: 'assets/buttons/button_no_cut.png',
                            leadingIcon: 'assets/icons/flag.svg',
                            text: 'NATION',
                            count: '0',
                            onTap: () {},
                          ),
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
                            leadingIcon: 'assets/icons/skip.svg',
                            text: 'SKIP',
                            count: '2',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: 'Fw.190D-9',
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/finish');
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: 'J29D',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: 'Yak-3P',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: 'Spitfire Mk.IX',
                        onTap: () {},
                      ),
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
