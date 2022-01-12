import 'package:flutter/material.dart';

import '../data/levels_collection.dart';
import '../models/level_model.dart';
import '../widgets/appbar_regular_widget.dart';
import '../widgets/list_item_level_widget.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  Future<List<LevelModel>> getLevels(String args) async {

    switch(args){
      case 'HARDCORE':
        return await LevelsCollection().AddHardcoreLevel();
      case 'TRAINING':
        return await LevelsCollection().AddTrainingLevel();
      default:
        return await LevelsCollection().AddClassicLevel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
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
                AppBarRegularWidget(
                  context: context,
                  isBackArrowShown: true,
                  centerLabel: args,
                  icon: '',
                ),
                Expanded(
                  child: FutureBuilder<List<LevelModel>>(
                      future: getLevels(args),
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
                                return ListItemLevelWidget(
                                  context: context,
                                  level: snapshot.data![index],
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
