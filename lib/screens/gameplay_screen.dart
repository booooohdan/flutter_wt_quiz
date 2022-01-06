import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wt_quiz/models/gameplay_button_model.dart';
import 'package:wt_quiz/widgets/button_gameplay_widget.dart';

import '../data/planes_collection.dart';
import '../models/game_process.dart';
import '../models/level.dart';
import '../models/vehicle.dart';
import '../providers/level_provider.dart';
import '../utilities/constants.dart';
import '../utilities/svg_paths/button_cut_left_bottom_edge.dart';
import '../utilities/svg_paths/button_cut_right_bottom_edge.dart';
import '../utilities/svg_paths/button_no_cut.dart';
import '../widgets/appbar_gameplay.dart';
import '../widgets/button_wide.dart';
import '../widgets/button_square.dart';

class GameplayScreen extends StatefulWidget {
  GameplayScreen({Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  Level? level;
  late List<Vehicle> vehicles = [];
  List<GameplayButtonModel> buttons = [];
  GameProcess? gameProcess;
  Vehicle? vehicleCorrectAnswer;
  bool ignoreClicks = false;

  final _random = Random();

  var button1 = GameplayButtonModel();
  var button2 = GameplayButtonModel();
  var button3 = GameplayButtonModel();
  var button4 = GameplayButtonModel();

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
    buttons..add(button1)..add(button2)..add(button3)..add(button4);
    shuffleListAndAssignButtonName();
  }

  void shuffleListAndAssignButtonName() {
    final shuffledList = List.from(vehicles)..shuffle();
    buttons[0].answerText = shuffledList[0].name!;
    buttons[1].answerText = shuffledList[1].name!;
    buttons[2].answerText = shuffledList[2].name!;
    buttons[3].answerText = shuffledList[3].name!;

    vehicleCorrectAnswer = shuffledList[_random.nextInt(4)];
    setState(() {});
  }

  Function()? answerSelected(GameplayButtonModel model) {
    ignoreClicks = true;
    if (model.answerText == vehicleCorrectAnswer!.name) {
      var a = 5;
    } else {
      var a = 6;
    }

    checkCorrectButton()
        .then((value) => shuffleListAndAssignButtonName())
        .then((value) => ignoreClicks = false);
  }

  Future checkCorrectButton() async {
    final correctButton = buttons
        .where((element) => element.answerText == vehicleCorrectAnswer!.name)
        .first;

    setState(() => correctButton.isGreenBlink = true);
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() => correctButton.isGreenBlink = false);
    // await Future.delayed(Duration(milliseconds: 500));
    // setState(() => correctButton.isGreenBlink = true);
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image(
                      image: AssetImage(
                          'assets/planes/${vehicleCorrectAnswer!.image}.png'),
                      fit: BoxFit.fitHeight,
                    ),
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
                  child: IgnorePointer(
                    ignoring: ignoreClicks,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonGameplayWidget(
                          context: context,
                          onTap: () => answerSelected(buttons[0]),
                          model: buttons[0],
                        ),
                        ButtonGameplayWidget(
                          context: context,
                          onTap: () => answerSelected(buttons[1]),
                          model: buttons[1],
                        ),
                        ButtonGameplayWidget(
                          context: context,
                          onTap: () => answerSelected(buttons[2]),
                          model: buttons[2],
                        ),
                        ButtonGameplayWidget(
                          context: context,
                          onTap: () => answerSelected(buttons[3]),
                          model: buttons[3],
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
    );
  }
}
