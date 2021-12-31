import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/first_provider.dart';
import '../screens/finish_screen.dart';
import '../screens/gameplay_screen.dart';
import '../screens/levels_screen.dart';
import '../screens/login_screen.dart';
import '../screens/menu_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirstProvider>(
          create: (_) => FirstProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'WT Quiz',
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: TextTheme(

          )
        ),
        routes: {
          '/': (context) => MenuScreen(),
          '/login': (context) => LoginScreen(),
          '/levels': (context) => LevelsScreen(),
          '/gameplay': (context) => GameplayScreen(),
          '/finish': (context) => FinishScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
