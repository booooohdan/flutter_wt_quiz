import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../models/game_process_model.dart';
import '../models/gameplay_button_model.dart';
import '../models/level_model.dart';
import '../models/vehicle_model.dart';
import '../providers/ads_provider.dart';
import '../providers/game_process_provider.dart';
import '../providers/level_provider.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_gameplay_widget.dart';
import '../widgets/button_gameplay_widget.dart';
import '../widgets/button_square_widget.dart';
import '../widgets/custom_alert_dialog.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  LevelModel? level;
  GameProcessModel? gameProcess;
  List<VehicleModel>? vehicles;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  List<GameplayButtonModel> buttons = [];
  late VehicleModel vehicleCorrectAnswer;
  late Timer timer;

  var button1 = GameplayButtonModel();
  var button2 = GameplayButtonModel();
  var button3 = GameplayButtonModel();
  var button4 = GameplayButtonModel();
  var nationHintIcon = 'assets/icons/flag.svg';
  var ignoreClicks = false;
  var random = Random();
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;
  bool isFirstInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstInit) {
      isFirstInit = true;
      level = context.watch<LevelProvider>().currentLevel;

      buttons
        ..add(button1)
        ..add(button2)
        ..add(button3)
        ..add(button4);

      gameProcess =
          context.read<GameProcessProvider>().setLevelDifficultParams(level!);

      vehicles = context.read<GameProcessProvider>().addVehicles(level!);

      initNewQuestion();
      loadInterstitialAd();
      loadRewardedAd();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    _interstitialAd!.dispose();
    _rewardedAd!.dispose();
    super.dispose();
  }

  void initNewQuestion() {
    gameProcess!.questionCurrent++;

    final isQuestionOver =
        gameProcess!.questionCurrent > gameProcess!.questionsTotal;
    final isLivesOver = gameProcess!.heartsCount <= 0;

    if (isQuestionOver) {
      finishTheGame();
      return;
    }

    if (isLivesOver) {
      if (isRewardedAdReady) {
        addExtraLifeCustomDialog(context);
      } else {
        finishTheGame();
      }
    }

    if (!isQuestionOver && !isLivesOver) {
      selectQuestionsAndRandomAnswers();
    }
  }

  void finishTheGame() {
    context.read<GameProcessProvider>().setGameProcess(gameProcess!);

    if (isInterstitialAdReady) {
      _interstitialAd?.show();
    } else {
      Navigator.pushReplacementNamed(context, '/finish');
    }
  }

  void selectQuestionsAndRandomAnswers() {

    //reload vehicles list when they count is over
    if (vehicles!.length <= 4) {
      vehicles = context.read<GameProcessProvider>().addVehicles(level!);
    }

    List<VehicleModel> shuffledList = List.from(vehicles!)..shuffle();
    vehicleCorrectAnswer = shuffledList[random.nextInt(4)];

    //except repetitive questions ability
    vehicles!
        .removeWhere((element) => element.name == vehicleCorrectAnswer.name);

    switch (vehicleCorrectAnswer.type) {
      case 'Plane':
        shuffledList.removeWhere((element) => element.type == 'Tank');
        shuffledList.removeWhere((element) => element.type == 'Ship');
        break;
      case 'Tank':
        shuffledList.removeWhere((element) => element.type == 'Plane');
        shuffledList.removeWhere((element) => element.type == 'Ship');
        break;
      case 'Ship':
        shuffledList.removeWhere((element) => element.type == 'Plane');
        shuffledList.removeWhere((element) => element.type == 'Tank');
        break;
    }

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
    gameProcess!.hintFiftyFifty--;
    gameProcess!.hintsUsed++;
  }

  void nationHint() {
    nationHintIcon = 'assets/icons/${vehicleCorrectAnswer.nation}.svg';
    setState(() {});
    gameProcess!.hintNation--;
    gameProcess!.hintsUsed++;
  }

  void skipHint() {
    timer.cancel();
    selectQuestionsAndRandomAnswers();
    setState(() {});
    gameProcess!.hintSkip--;
    gameProcess!.hintsUsed++;
  }

  void startTimer() {
    gameProcess!.timeCurrent = gameProcess!.timeExpected;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (gameProcess!.timeCurrent == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            gameProcess!.timeCurrent--;
          });
        }
      },
    );
  }

  Function()? answerButtonTapped(GameplayButtonModel model) {
    ignoreClicks = true;

    //Small fix for timer tick +1 bug
    timer.tick > gameProcess!.timeExpected
        ? gameProcess!.timeAverage += gameProcess!.timeExpected
        : gameProcess!.timeAverage += timer.tick;
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
      gameProcess!.correctAnswersCount++;
    } else {
      gameProcess!.heartsCount--;
    }
  }

  Future blinkCorrectButton() async {
    final correctButton = buttons
        .where((element) => element.answerText == vehicleCorrectAnswer.name)
        .first;

    setState(() => correctButton.isGreenBlink = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = false);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => correctButton.isGreenBlink = false);
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: context.watch<AdsProvider>().interstitialId(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pushReplacementNamed(context, '/finish');
            },
          );

          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: context.watch<AdsProvider>().extraLifeRewardId(),
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                isRewardedAdReady = false;
              });
              loadRewardedAd();
            },
          );

          setState(() {
            isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return await backButtonCustomDialog(context);
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
                    gameProcess: gameProcess!,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${gameProcess!.timeCurrent} s',
                          style: oxygen14whiteBold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width / 2,
                          child: LinearProgressIndicator(
                            color: Colors.white,
                            backgroundColor: greyTextColor,
                            value: gameProcess!.timeCurrent /
                                gameProcess!.timeExpected,
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
                              'assets/vehicles/${vehicleCorrectAnswer.image}.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    height: height / 8,
                    width: 560,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: IgnorePointer(
                            ignoring: gameProcess!.hintFiftyFifty == 0,
                            child: ButtonSquareWidget(
                              context: context,
                              clipper: ButtonCutLeftBottomEdge(),
                              backgroundImage:
                                  'assets/buttons/button_cut_left_bottom_edge.png',
                              leadingIcon: 'assets/icons/fifty_fifty.svg',
                              text: '50/50',
                              count: '${gameProcess!.hintFiftyFifty}',
                              onTap: () {
                                fiftyFiftyHints();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: IgnorePointer(
                            ignoring: gameProcess!.hintNation == 0,
                            child: ButtonSquareWidget(
                              context: context,
                              clipper: ButtonNoCut(),
                              backgroundImage:
                                  'assets/buttons/button_no_cut.png',
                              leadingIcon: nationHintIcon,
                              text: 'NATION',
                              count: '${gameProcess!.hintNation}',
                              onTap: () {
                                nationHint();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: IgnorePointer(
                            ignoring: gameProcess!.hintSkip == 0,
                            child: ButtonSquareWidget(
                              context: context,
                              clipper: ButtonCutRightBottomEdge(),
                              backgroundImage:
                                  'assets/buttons/button_cut_right_bottom_edge.png',
                              leadingIcon: 'assets/icons/skip.svg',
                              text: 'SKIP',
                              count: '${gameProcess!.hintSkip}',
                              onTap: () {
                                skipHint();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: IgnorePointer(
                      ignoring: ignoreClicks,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Visibility(
                              visible: buttons[0].answerText.isNotEmpty,
                              child: ButtonGameplayWidget(
                                context: context,
                                onTap: () => answerButtonTapped(buttons[0]),
                                model: buttons[0],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 3,
                            child: Visibility(
                              visible: buttons[1].answerText.isNotEmpty,
                              child: ButtonGameplayWidget(
                                context: context,
                                onTap: () => answerButtonTapped(buttons[1]),
                                model: buttons[1],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 3,
                            child: Visibility(
                              visible: buttons[2].answerText.isNotEmpty,
                              child: ButtonGameplayWidget(
                                context: context,
                                onTap: () => answerButtonTapped(buttons[2]),
                                model: buttons[2],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 3,
                            child: Visibility(
                              visible: buttons[3].answerText.isNotEmpty,
                              child: ButtonGameplayWidget(
                                context: context,
                                onTap: () => answerButtonTapped(buttons[3]),
                                model: buttons[3],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
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

  Future<bool> backButtonCustomDialog(BuildContext context) async {
    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (c) => CustomAlertDialog(
            title: 'Do you really want to exit?',
            leftButtonIcon: 'assets/icons/yes.svg',
            leftButtonText: 'Yes',
            rightButtonIcon: 'assets/icons/no.svg',
            rightButtonText: 'No',
            onLeftTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onRightTap: () {
              Navigator.of(context).pop();
            },
          ),
        ) ??
        false;
  }

  Future<bool> addExtraLifeCustomDialog(BuildContext context) async {
    final _timer = Timer(Duration(seconds: 5), () {
      Navigator.of(context).pop();
      finishTheGame();
    });

    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (c) => CustomAlertDialog(
            title: 'Use extra life to continue?',
            leftButtonIcon: 'assets/icons/no.svg',
            leftButtonText: 'No',
            rightButtonIcon: 'assets/icons/video_ad.svg',
            rightButtonText: 'YES!',
            onLeftTap: () {
              _timer.cancel();
              Navigator.of(context).pop();
              finishTheGame();
            },
            onRightTap: () {
              _timer.cancel();
              Navigator.of(context).pop();
              {
                _rewardedAd!.show(
                    onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
                  gameProcess!.heartsCount++;
                  setState(() {});
                });
              }
            },
          ),
        ) ??
        false;
  }
}
