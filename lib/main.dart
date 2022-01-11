import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_process_provider.dart';
import '../providers/level_provider.dart';
import '../screens/feedback_screen.dart';
import '../screens/finish_screen.dart';
import '../screens/gameplay_screen.dart';
import '../screens/levels_screen.dart';
import '../screens/login_screen.dart';
import '../screens/menu_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LevelProvider>(
          create: (_) => LevelProvider(),
        ),
        ChangeNotifierProvider<GameProcessProvider>(
          create: (_) => GameProcessProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'WT Quiz',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        routes: {
          '/': (context) => MenuScreen(),
          '/login': (context) => LoginScreen(),
          '/levels': (context) => LevelsScreen(),
          '/gameplay': (context) => GameplayScreen(),
          '/finish': (context) => FinishScreen(),
          '/feedback': (context) => FeedbackScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
