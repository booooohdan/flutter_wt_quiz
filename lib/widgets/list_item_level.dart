import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';
import '../utilities/svg_paths/wide_button_cut_right_bottom_edge.dart';

class ListItemLevel extends StatelessWidget {
  const ListItemLevel({
    Key? key,
    required this.context,
    required this.number,
    required this.questionCount,
    required this.answeredCount,
    this.isPlane = false,
    this.isTank = false,
    this.isShip = false,
    required this.levelStatus,
    required this.periodOfTime,
  }) : super(key: key);

  final BuildContext context;
  final int? number;
  final int? questionCount;
  final int? answeredCount;
  final bool? isPlane;
  final bool? isTank;
  final bool? isShip;
  final String? levelStatus;
  final String? periodOfTime;

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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 20),
                        child: Image.asset(
                            'assets/images/$levelStatus.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Level $number',
                            style: chakra16white,
                          ),
                          Row(
                            children: [
                              isPlane!
                                  ? SvgPicture.asset(
                                      'assets/icons/plane.svg',
                                      width: 15,
                                    )
                                  : Container(),
                              SizedBox(width: 5),
                              isTank!
                                  ? SvgPicture.asset(
                                      'assets/icons/tank.svg',
                                      width: 25,
                                    )
                                  : Container(),
                              SizedBox(width: 5),
                              isShip!
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
                              text: TextSpan(style: chakra20white, children: [
                            TextSpan(text: '$answeredCount'),
                            TextSpan(text: '/$questionCount', style: chakra14white),
                          ])),
                          Text(
                            periodOfTime!,
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
