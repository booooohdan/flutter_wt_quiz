import 'package:flutter/material.dart';

import '../data/levels_collection.dart';
import '../widgets/list_item_level.dart';
import '../widgets/appbar_regular.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final levels = LevelsCollection().classicLevels;

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
                AppBarRegular(context: context),
                Expanded(
                  child: ListView.builder(
                      itemCount: levels.length,
                      itemBuilder: (context, index) {
                        return ListItemLevel(
                          context: context,
                          number: levels[index].number,
                          questionCount: levels[index].questionCount,
                        );
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
