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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameResult = context.watch<GameProcessProvider>().currentGameProcess;
    level = context.watch<LevelProvider>().currentLevel;
    initResultData();
  }

  void initResultData() {
    isSuccess =
        gameResult!.correctAnswersCount / gameResult!.questionsTotal >= 0.9;
    answerAccuracy =
        (gameResult!.correctAnswersCount / gameResult!.questionsTotal) * 100;
    averageTime = gameResult!.timeAverage / (gameResult!.questionCurrent - 1);
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
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                AppBarRegularWidget(
                  context: context,
                  isBackArrowShown: false,
                  centerLabel: 'Finish',
                  icon: '',
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.bottom,
                      children: [
                        TableRow(children: [
                          Text(
                            'Answers Accuracy: ',
                            style: oxygen14whiteNormal,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${answerAccuracy.toStringAsFixed(0)} %',
                              style: chakra22white,
                            ),
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            'Average Answer Time: ',
                            style: oxygen14whiteNormal,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${averageTime.toStringAsFixed(1)} s',
                              style: chakra22white,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Classic: Level ${level!.number}',
                        style: chakra22white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 20, right: 20),
                        child: Stack(children: [
                          isSuccess
                              ? Image.asset('assets/images/success.png')
                              : Image.asset('assets/images/failed.png'),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(
                          style: chakra48white,
                          children: [
                            TextSpan(
                                text: '${gameResult!.correctAnswersCount}'),
                            TextSpan(
                                text: '/${level!.questionCount}',
                                style: chakra22white),
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
                                  onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: ButtonSquareWidget(
                                  context: context,
                                  clipper: ButtonCutRightBottomEdge(),
                                  backgroundImage:
                                      'assets/buttons/button_cut_right_bottom_edge.png',
                                  leadingIcon: 'assets/icons/right_arrow.svg',
                                  text: 'NEXT LEVEL',
                                  count: '',
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
