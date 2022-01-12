import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wt_quiz/utilities/constants.dart';

import '../data/planes_collection.dart';
import '../models/game_process_model.dart';
import '../models/gameplay_button_model.dart';
import '../models/level_model.dart';
import '../models/vehicle_model.dart';
import '../providers/game_process_provider.dart';
import '../providers/level_provider.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_gameplay_widget.dart';
import '../widgets/button_gameplay_widget.dart';
import '../widgets/button_square_widget.dart';

class GameplayScreen extends StatefulWidget {
  GameplayScreen({Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  LevelModel? level;
  List<VehicleModel> vehicles = [];
  List<GameplayButtonModel> buttons = [];
  late GameProcessModel gameProcess;
  late VehicleModel vehicleCorrectAnswer;
  late Timer timer;
  bool ignoreClicks = false;
  String nationHintIcon = 'assets/icons/flag.svg';

  var button1 = GameplayButtonModel();
  var button2 = GameplayButtonModel();
  var button3 = GameplayButtonModel();
  var button4 = GameplayButtonModel();
  var random = Random();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    level = context.watch<LevelProvider>().currentLevel;

    if (level!.isPlane!) {
      vehicles.addAll(planes);
    }
    if (level!.isTank!) {
      //TODO: Uncomment when collection of tanks will be ready
      //vehicles.addAll(tanks);
    }
    if (level!.isTank!) {
      //TODO: Uncomment when collection of ships will be ready
      //vehicles.addAll(ships);
    }

    buttons
      ..add(button1)
      ..add(button2)
      ..add(button3)
      ..add(button4);

    if (level!.levelType == levelTypes['classic']) {
      gameProcess = GameProcessModel()
        ..heartsCount = 3
        ..questionsTotal = level!.questionCount!
        ..timeExpected = 10
        ..hintFiftyFifty = 1
        ..hintNation = 1
        ..hintSkip = 1;
    }

    if (level!.levelType == levelTypes['hardcore']) {
      gameProcess = GameProcessModel()
        ..heartsCount = 1
        ..questionsTotal = level!.questionCount!
        ..timeExpected = 5
        ..hintFiftyFifty = 1
        ..hintNation = 1
        ..hintSkip = 1;
    }

    if (level!.levelType == levelTypes['insane']) {
      gameProcess = GameProcessModel()
        ..heartsCount = 1
        ..questionsTotal = level!.questionCount!
        ..timeExpected = 3
        ..hintFiftyFifty = 0
        ..hintNation = 0
        ..hintSkip = 0;
    }

    if (level!.levelType == levelTypes['training']) {
      gameProcess = GameProcessModel()
        ..heartsCount = level!.questionCount!
        ..questionsTotal = level!.questionCount!
        ..timeExpected = level!.questionCount!
        ..hintFiftyFifty = level!.questionCount!
        ..hintNation = level!.questionCount!
        ..hintSkip = level!.questionCount!;
    }

    initNewQuestion();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void initNewQuestion() {
    gameProcess.questionCurrent++;

    final isQuestionOver =
        gameProcess.questionCurrent > gameProcess.questionsTotal;
    final isLivesOver = gameProcess.heartsCount <= 0;
    if (isQuestionOver || isLivesOver) {
      context.read<GameProcessProvider>().setGameProcess(gameProcess);
      Navigator.pushReplacementNamed(context, '/finish');
      return;
    }

    selectQuestionsAndRandomAnswers();
  }

  void selectQuestionsAndRandomAnswers() {
    final shuffledList = List.from(vehicles)..shuffle();
    vehicleCorrectAnswer = shuffledList[random.nextInt(4)];

    buttons[0].answerText = shuffledList[0].name!;
    buttons[1].answerText = shuffledList[1].name!;
    buttons[2].answerText = shuffledList[2].name!;
    buttons[3].answerText = shuffledList[3].name!;
    startTimer();
  }

  void fiftyFiftyHints() {
    final correctIndex = buttons.indexOf(buttons
        .where((element) => element.answerText == vehicleCorrectAnswer.name)
        .first);

    switch (correctIndex) {
      case 0:
        buttons[1].answerText = '';
        buttons[2].answerText = '';
        break;
      case 1:
        buttons[0].answerText = '';
        buttons[3].answerText = '';
        break;
      case 2:
        buttons[0].answerText = '';
        buttons[3].answerText = '';
        break;
      case 3:
        buttons[1].answerText = '';
        buttons[2].answerText = '';
        break;
    }

    setState(() {});
    gameProcess.hintFiftyFifty -= 1;
  }

  void nationHint() {
    nationHintIcon = 'assets/icons/${vehicleCorrectAnswer.nation}.svg';
    setState(() {});
    gameProcess.hintNation -= 1;
  }

  void skipHint() {
    timer.cancel();
    selectQuestionsAndRandomAnswers();
    setState(() {});
    gameProcess.hintSkip -= 1;
  }

  void startTimer() {
    gameProcess.timeCurrent = gameProcess.timeExpected;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (gameProcess.timeCurrent == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            gameProcess.timeCurrent--;
          });
        }
      },
    );
  }

  Function()? answerButtonTapped(GameplayButtonModel model) {
    ignoreClicks = true;

    //Small fix for timer tick +1 bug
    timer.tick > gameProcess.timeExpected
        ? gameProcess.timeAverage += gameProcess.timeExpected
        : gameProcess.timeAverage += timer.tick;
    //Small fix for timer tick +1 bug

    timer.cancel();

    blinkCorrectButton()
        .then((value) =>
            correctAnswerHandler(model.answerText == vehicleCorrectAnswer.name))
        .then((value) => initNewQuestion())
        .then((value) => ignoreClicks = false);
  }

  void correctAnswerHandler(bool isCorrect) {
    if (isCorrect) {
      gameProcess.correctAnswersCount++;
    } else {
      gameProcess.heartsCount--;
    }
  }

  Future blinkCorrectButton() async {
    final correctButton = buttons
        .where((element) => element.answerText == vehicleCorrectAnswer.name)
        .first;

    setState(() => correctButton.isGreenBlink = true);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = false);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = true);
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog<bool>(
              context: context,
              builder: (c) => Dialog(
                //backgroundColor: Colors.transparent,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Column(
                    children: [
                      Text('Do you really want to exit?'),
                      Row(
                        children: [
                          ButtonSquareWidget(
                            context: context,
                            clipper: ButtonCutLeftBottomEdge(),
                            backgroundImage:
                                'assets/buttons/button_cut_left_bottom_edge.png',
                            leadingIcon: 'assets/icons/fifty_fifty.svg',
                            text: 'Yes',
                            count: '',
                            onTap: () {},
                          ),
                          ButtonSquareWidget(
                            context: context,
                            clipper: ButtonCutRightBottomEdge(),
                            backgroundImage:
                                'assets/buttons/button_cut_right_bottom_edge.png',
                            leadingIcon: 'assets/icons/fifty_fifty.svg',
                            text: 'No',
                            count: '',
                            onTap: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //backgroundColor: Colors.red,
                // title: Text('Warning'),
                // content: Text('Do you really want to exit?'),
                // actions: [
                //   TextButton(
                //     child: Text('Yes'),
                //     onPressed: () => Navigator.pop(c, true),
                //   ),
                //   TextButton(
                //     child: Text('No'),
                //     onPressed: () => Navigator.pop(c, false),
                //   ),
                // ],
              ),
            ) ??
            false;
      },
      child: Stack(
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
                  AppBarGameplayWidget(
                    context: context,
                    gameProcess: gameProcess,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${gameProcess.timeCurrent} s',
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
                            value: gameProcess.timeCurrent /
                                gameProcess.timeExpected,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InteractiveViewer(
                        child: Image(
                          image: AssetImage(
                              'assets/planes/${vehicleCorrectAnswer.image}.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: IgnorePointer(
                              ignoring: gameProcess.hintFiftyFifty == 0,
                              child: ButtonSquareWidget(
                                context: context,
                                clipper: ButtonCutLeftBottomEdge(),
                                backgroundImage:
                                    'assets/buttons/button_cut_left_bottom_edge.png',
                                leadingIcon: 'assets/icons/fifty_fifty.svg',
                                text: '50/50',
                                count: '${gameProcess.hintFiftyFifty}',
                                onTap: () {
                                  fiftyFiftyHints();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: IgnorePointer(
                              ignoring: gameProcess.hintNation == 0,
                              child: ButtonSquareWidget(
                                context: context,
                                clipper: ButtonNoCut(),
                                backgroundImage:
                                    'assets/buttons/button_no_cut.png',
                                leadingIcon: nationHintIcon,
                                text: 'NATION',
                                count: '${gameProcess.hintNation}',
                                onTap: () {
                                  nationHint();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: IgnorePointer(
                              ignoring: gameProcess.hintSkip == 0,
                              child: ButtonSquareWidget(
                                context: context,
                                clipper: ButtonCutRightBottomEdge(),
                                backgroundImage:
                                    'assets/buttons/button_cut_right_bottom_edge.png',
                                leadingIcon: 'assets/icons/skip.svg',
                                text: 'SKIP',
                                count: '${gameProcess.hintSkip}',
                                onTap: () {
                                  skipHint();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: IgnorePointer(
                      ignoring: ignoreClicks,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Visibility(
                            visible: buttons[0].answerText.isNotEmpty,
                            child: ButtonGameplayWidget(
                              context: context,
                              onTap: () => answerButtonTapped(buttons[0]),
                              model: buttons[0],
                            ),
                          ),
                          Visibility(
                            visible: buttons[1].answerText.isNotEmpty,
                            child: ButtonGameplayWidget(
                              context: context,
                              onTap: () => answerButtonTapped(buttons[1]),
                              model: buttons[1],
                            ),
                          ),
                          Visibility(
                            visible: buttons[2].answerText.isNotEmpty,
                            child: ButtonGameplayWidget(
                              context: context,
                              onTap: () => answerButtonTapped(buttons[2]),
                              model: buttons[2],
                            ),
                          ),
                          Visibility(
                            visible: buttons[3].answerText.isNotEmpty,
                            child: ButtonGameplayWidget(
                              context: context,
                              onTap: () => answerButtonTapped(buttons[3]),
                              model: buttons[3],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
