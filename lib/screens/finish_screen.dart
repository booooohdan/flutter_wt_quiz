import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/game_process_model.dart';
import '../models/level_model.dart';
import '../providers/ads_provider.dart';
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
  GameProcessModel? gameResult;
  LevelModel? level;
  RewardedAd? rewardedAd;
  bool isSuccess = false;
  double answerAccuracy = 0.0;
  double averageTime = 0.0;
  double leaderboardPoints = 0.0;
  bool isRewardedAdReady = false;
  bool isFirstInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isFirstInit) {
      isFirstInit = true;
      gameResult = context.watch<GameProcessProvider>().currentGameProcess;
      level = context.watch<LevelProvider>().currentLevel;
      initResultData();
      loadRewardedAd();
    }
  }

  @override
  void dispose() {
    rewardedAd!.dispose();
    super.dispose();
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

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: context.watch<AdsProvider>().doublePointRewardId(),
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                isRewardedAdReady = false;
              });
              //loadRewardedAd();
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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: isSuccess
                  ? const AssetImage('assets/backgrounds/finish_success.png')
                  : const AssetImage('assets/backgrounds/finish_failed.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: isSuccess
                ? Lottie.asset('assets/animations/success.json')
                : Lottie.asset('assets/animations/failed.json')),
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
                    width: width / 1.6,
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.bottom,
                      children: [
                        buildTableRow('Correct answers: ',
                            '${gameResult!.correctAnswersCount}/${level!.questionCount}'),
                        buildTableRow('Accuracy: ',
                            '${answerAccuracy.toStringAsFixed(0)}%'),
                        buildTableRow('Average time: ',
                            '${averageTime.toStringAsFixed(1)} s'),
                        buildTableRow(
                            'Hints used: ', '${gameResult!.hintsUsed}'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/star_circle.svg',
                            color: Colors.white,
                            height: height / 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${leaderboardPoints.toStringAsFixed(0)}',
                            style: chakra48whiteBold,
                          ),
                        ],
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
                          visible: isRewardedAdReady,
                          maintainState: true,
                          maintainAnimation: true,
                          maintainSize: true,
                          child: ButtonWideWidget(
                            context: context,
                            icon: '',
                            title: 'DOUBLE POINTS',
                            backgroundColor: greenButtonColor,
                            textColor: Colors.black,
                            onTap: () {
                              rewardedAd!.show(onUserEarnedReward:
                                  (RewardedAd ad, RewardItem reward) {
                                final updatedReward = leaderboardPoints * 2;
                                leaderboardPoints = updatedReward;
                                setState(() {});
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          width: 560,
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
                const SizedBox(height: 50)
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
