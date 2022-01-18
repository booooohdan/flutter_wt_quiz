import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/level_model.dart';
import '../providers/level_provider.dart';
import '../widgets/appbar_regular_widget.dart';
import '../widgets/list_item_level_widget.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({Key? key}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
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
                      future: context
                          .read<LevelProvider>()
                          .addLevels(args),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                          shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListItemLevelWidget(
                                    context: context,
                                    level: snapshot.data![index],
                                  );
                                });
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
