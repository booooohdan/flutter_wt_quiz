import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game_process_model.dart';
import '../models/level_model.dart';
import '../providers/game_process_provider.dart';
import '../providers/level_provider.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../widgets/appbar_regular_widget.dart';
import '../widgets/button_square_widget.dart';
import '../widgets/button_wide_widget.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  //with SingleTickerProviderStateMixin {
  GameProcessModel? gameResult;
  LevelModel? level;
  bool isSuccess = false;
  double answerAccuracy = 0.0;
  double averageTime = 0.0;
  double leaderboardPoints = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameResult = context.watch<GameProcessProvider>().currentGameProcess;
    level = context.watch<LevelProvider>().currentLevel;
    initResultData();
  }

  void initResultData() {
    final double multiplier;
    final correctToTotalRatio =
        gameResult!.correctAnswersCount / gameResult!.questionsTotal;
    averageTime = gameResult!.timeAverage / (gameResult!.questionCurrent - 1);
    isSuccess = correctToTotalRatio >= 0.9;
    answerAccuracy = correctToTotalRatio * 100;

    gameResult!.timeExpected - averageTime < 1
        ? multiplier = 1
        : multiplier = gameResult!.timeExpected - averageTime;

    leaderboardPoints = gameResult!.correctAnswersCount * multiplier;

    context.read<LevelProvider>().saveResultToPreferences(
        correctToTotalRatio, gameResult!.correctAnswersCount);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: isSuccess
                  ? AssetImage('assets/backgrounds/finish_success.png')
                  : AssetImage('assets/backgrounds/finish_failed.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: isSuccess
              ? Image.asset(
                  'assets/images/glow_success.png',
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/glow_failed.png',
                  fit: BoxFit.cover,
                ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Stack(children: [
              isSuccess
                  ? Image.asset('assets/images/success.png')
                  : Image.asset('assets/images/failed.png'),
            ]),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegularWidget(
                  context: context,
                  isBackArrowShown: false,
                  centerLabel: 'FINISH',
                  icon: '',
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.bottom,
                      children: [
                        buildTableRow('Average answer time: ',
                            '${averageTime.toStringAsFixed(1)} s'),
                        buildTableRow('Accuracy: ',
                            '${answerAccuracy.toStringAsFixed(0)} %'),
                        buildTableRow('Points: ',
                            '${leaderboardPoints.toStringAsFixed(0)}'),
                        buildTableRow('Hints used: ', '1'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${level!.levelType}: ${level!.name}',
                        style: chakra22whiteBold,
                      ),
                      RichText(
                        text: TextSpan(
                          style: chakra48whiteBold,
                          children: [
                            TextSpan(
                                text: '${gameResult!.correctAnswersCount}'),
                            TextSpan(
                                text: '/${level!.questionCount}',
                                style: chakra22whiteBold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: false,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: ButtonWideWidget(
                            context: context,
                            icon: '',
                            title: 'DOUBLE POINTS',
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ButtonSquareWidget(
                                  context: context,
                                  clipper: ButtonCutLeftBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_left_bottom_edge.png',
                                  leadingIcon: 'assets/icons/home.svg',
                                  text: 'HOME',
                                  count: '',
                                  onTap: () =>
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/', (r) => false),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 1,
                                child: ButtonSquareWidget(
                                  context: context,
                                  clipper: ButtonCutRightBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_right_bottom_edge.png',
                                  leadingIcon: 'assets/icons/right_arrow.svg',
                                  text: '${isSuccess ? 'NEXT LEVEL' : 'RETRY'}',
                                  count: '',
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (r) => false);
                                    Navigator.pushNamed(context, '/levels',
                                        arguments:
                                            level!.levelType!.toUpperCase());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow buildTableRow(String name, String value) {
    return TableRow(children: [
      Text(
        name,
        style: oxygen14whiteRegular,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          value,
          style: chakra22whiteBold,
        ),
      ),
    ]);
  }
}
