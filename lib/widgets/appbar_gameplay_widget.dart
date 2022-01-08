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
      case 1:
        return ['heart_fill', 'heart_stroke', 'heart_stroke'];
      case 2:
        return ['heart_fill', 'heart_fill', 'heart_stroke'];
      case 3:
        return ['heart_fill', 'heart_fill', 'heart_fill'];
      default:
        return ['heart_stroke', 'heart_stroke', 'heart_stroke'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
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
                        style: chakra18white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icons/checkmark.svg',
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[0]}.svg',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[1]}.svg',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/${heartsList()[2]}.svg',
                    width: 20,
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
                      style: chakra22white,
                      children: [
                        TextSpan(text: '${gameProcess.questionCurrent}'),
                        TextSpan(
                            text: '/${gameProcess.questionsTotal}',
                            style: chakra14white),
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
          height: 5,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
