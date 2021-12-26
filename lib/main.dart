import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wt_quiz/screens/login_screen.dart';
import 'package:wt_quiz/screens/menu_screen.dart';

import 'providers/first_provider.dart';

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
        routes: {
          '/': (context) => MenuScreen(),
          '/login':(context) => LoginScreen(),
          // '/mainmenu': (context) => HomeTabBarScreen(),
          // '/profile': (context) => Profile(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
