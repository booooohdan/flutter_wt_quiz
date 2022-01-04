import 'package:flutter/material.dart';
import 'package:wt_quiz/models/level.dart';

import '../data/levels_collection.dart';
import '../widgets/appbar_regular.dart';
import '../widgets/list_item_level.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  Future<List<Level>> getLevels() async {
    return await LevelsCollection().AddLevel();
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
                AppBarRegular(
                  context: context,
                  isBackArrowShown: true,
                  centerLabel: 'Classic',
                  icon: '',
                ),
                Expanded(
                  child: FutureBuilder<List<Level>>(
                      future: getLevels(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListItemLevel(
                                  context: context,
                                  number: snapshot.data![index].number,
                                  questionCount:
                                      snapshot.data![index].questionCount,
                                  answeredCount:
                                      snapshot.data![index].answeredCount,
                                  isPlane: snapshot.data![index].isPlane,
                                  isTank: snapshot.data![index].isTank,
                                  isShip: snapshot.data![index].isShip,
                                  levelStatus:
                                      snapshot.data![index].levelStatus,
                                  periodOfTime:
                                      snapshot.data![index].periodOfTime,
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
