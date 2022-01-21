import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/game_process_model.dart';

import '../utilities/constants.dart';

class AppBarGameplayWidget extends StatelessWidget {
  const AppBarGameplayWidget({
    Key? key,
    required this.context,
    required this.gameProcess,
  }) : super(key: key);

  final BuildContext context;
  final GameProcessModel gameProcess;

  List<String> heartsList() {
    switch (gameProcess.heartsCount) {
      case 0:
        return ['heart_stroke', 'heart_stroke', 'heart_stroke'];
      case 1:
        return ['heart_fill', 'heart_stroke', 'heart_stroke'];
      case 2:
        return ['heart_fill', 'heart_fill', 'heart_stroke'];
      default:
        return ['heart_fill', 'heart_fill', 'heart_fill'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height / 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Text(
                        '${gameProcess.correctAnswersCount}',
                        style: chakra18whiteBold,
                      ),
                      const SizedBox(
                        width: 10
                      ),
                      SvgPicture.asset(
                        'assets/icons/checkmark.svg',
                        height: height / 70,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[0]}.svg',
                    height: height/50,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[1]}.svg',
                    height: height/50,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[2]}.svg',
                    height: height/50,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  width: 80,
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: chakra22whiteBold,
                      children: [
                        TextSpan(text: '${gameProcess.questionCurrent}'),
                        TextSpan(
                            text: '/${gameProcess.questionsTotal}',
                            style: chakra14whiteBold),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          'assets/divider.svg',
          height: height / 150,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
