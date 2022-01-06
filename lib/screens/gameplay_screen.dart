import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import '../widgets/button_gameplay_wide.dart';
import '../widgets/button_square.dart';

class GameplayScreen extends StatefulWidget {
  GameplayScreen({Key? key}) : super(key: key);

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  Level? level;
  late List<Vehicle> vehicles = [];
  late GameProcess gameProcess;

  final _random = Random();
  String firstAnswerText = '';
  String secondAnswerText = '';
  String thirdAnswerText = '';
  String fourthAnswerText = '';

  Color firstButtonColor = Colors.transparent;
  Color secondButtonColor = Colors.transparent;
  Color thirdButtonColor = Colors.transparent;
  Color fourthButtonColor = Colors.transparent;
  Vehicle? vehicleCorrectAnswer;

  void shuffleTempList() {
    final shuffledList = List.from(vehicles)..shuffle();
    firstAnswerText = shuffledList[0].name!;
    secondAnswerText = shuffledList[1].name!;
    thirdAnswerText = shuffledList[2].name!;
    fourthAnswerText = shuffledList[3].name!;

    vehicleCorrectAnswer = shuffledList[_random.nextInt(4)];
    setState(() {});
  }

  Function()? answerSelected(String answerText) {
    if (answerText == vehicleCorrectAnswer!.name) {
      var a = 5;
    } else {
      var a = 6;
    }

    checkCorrectButton();
    //shuffleTempList();
  }

  void checkCorrectButton(){
    if(firstAnswerText == vehicleCorrectAnswer!.name){
      blinkButton(firstButtonColor);
    }
    if(secondAnswerText == vehicleCorrectAnswer!.name){
      blinkButton(secondButtonColor);
    }
    if(thirdAnswerText == vehicleCorrectAnswer!.name){
      blinkButton(thirdButtonColor);
    }
    if(fourthAnswerText == vehicleCorrectAnswer!.name){
      blinkButton(fourthButtonColor);
    }
  }

  Future blinkButton(Color buttonColor) async {
    setState(() {firstButtonColor = greenButtonColor;});
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {firstButtonColor = Colors.transparent;});
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {firstButtonColor = greenButtonColor;});
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {firstButtonColor = Colors.transparent;});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    level = context.watch<LevelProvider>().currentLevel;

    if (level!.isPlane!) {
      vehicles.addAll(planes);
    }
    if (level!.isTank!) {
      //vehicles.addAll(tanks);
    }
    if (level!.isTank!) {
      //vehicles.addAll(ships);
    }
    shuffleTempList();
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
                  child: Image(
                    image: AssetImage(
                        'assets/planes/${vehicleCorrectAnswer!.image}.png'),
                    fit: BoxFit.fitHeight,
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
                  child: Column(
                    children: [
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: firstAnswerText,
                        backgroundColor: firstButtonColor,
                        onTap: () => answerSelected(firstAnswerText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: secondAnswerText,
                        backgroundColor: secondButtonColor,
                        onTap: () => answerSelected(secondAnswerText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: thirdAnswerText,
                        backgroundColor: thirdButtonColor,
                        onTap: () => answerSelected(thirdAnswerText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonGameplayWide(
                        context: context,
                        icon: '',
                        title: fourthAnswerText,
                        backgroundColor: fourthButtonColor,
                        onTap: () => answerSelected(fourthAnswerText),
                      ),
                    ],
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
