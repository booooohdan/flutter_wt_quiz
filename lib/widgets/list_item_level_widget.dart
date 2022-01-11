import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/level_model.dart';
import '../providers/level_provider.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/wide_button_cut_right_bottom_edge.dart';

class ListItemLevelWidget extends StatelessWidget {
  ListItemLevelWidget({
    Key? key,
    required this.context,
    required this.level,
  }) : super(key: key);

  final BuildContext context;
  final LevelModel level;

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
                onTap: () {
                  context.read<LevelProvider>().setLevel(level);
                  Navigator.pushNamed(context, '/gameplay');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 20),
                        child: Image.asset(
                            'assets/images/${level.levelStatus}.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level ${level.number}',
                            style: chakra18white,
                          ),
                          Row(
                            children: [
                              level.isPlane!
                                  ? SvgPicture.asset(
                                      'assets/icons/plane.svg',
                                      width: 15,
                                    )
                                  : Container(),
                              SizedBox(width: 5),
                              level.isTank!
                                  ? SvgPicture.asset(
                                      'assets/icons/tank.svg',
                                      width: 25,
                                    )
                                  : Container(),
                              SizedBox(width: 5),
                              level.isShip!
                                  ? SvgPicture.asset(
                                      'assets/icons/ship.svg',
                                      width: 25,
                                    )
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: chakra22white,
                              children: [
                                TextSpan(text: '${level.answeredCount}'),
                                TextSpan(
                                    text: '/${level.questionCount}',
                                    style: chakra14white),
                              ],
                            ),
                          ),
                          Text(
                            level.periodOfTime!,
                            style: oxygen10white,
                          ),
                        ],
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