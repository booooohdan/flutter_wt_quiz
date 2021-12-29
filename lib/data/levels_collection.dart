import 'package:shared_preferences/shared_preferences.dart';

import '../models/level.dart';
import '../models/level_status.dart';
import '../models/period_of_time.dart';

class LevelsCollection {
  LevelsCollection() {
    AddLevel();
  }

  Level? le;
  List<Level> classicoLevels = [];

  void AddLevel() async{
    final prefs = await SharedPreferences.getInstance();

    le = Level()
      ..isShip = false
      ..questionCount = 1
    ..answeredCount = prefs.getInt('key') ?? 0;
    classicoLevels.add(le!);
  }

  List<Level> classicLevels = [
    Level(
      number: 1,
      questionCount: 5,
      answeredCount: 0,
      isPlane: false,
      isTank: false,
      isShip: false,
      levelStatus: LevelStatus.unlocked,
      periodOfTime: PeriodOfTime.preWWII,
    ),
    Level(
      number: 2,
      questionCount: 5,
    ),
    Level(
      number: 3,
      questionCount: 5,
    ),
    Level(
      number: 4,
      questionCount: 10,
    ),
    Level(
      number: 5,
      questionCount: 10,
    ),
    Level(
      number: 2,
      questionCount: 5,
    ),
    Level(
      number: 3,
      questionCount: 5,
    ),
    Level(
      number: 4,
      questionCount: 10,
    ),
    Level(
      number: 5,
      questionCount: 10,
    ),
    Level(
      number: 2,
      questionCount: 5,
    ),
    Level(
      number: 3,
      questionCount: 5,
    ),
    Level(
      number: 4,
      questionCount: 10,
    ),
    Level(
      number: 5,
      questionCount: 10,
    ),
  ];
}
