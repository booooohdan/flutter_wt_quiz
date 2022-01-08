import 'package:shared_preferences/shared_preferences.dart';
import '../models/level_model.dart';
import '../utilities/constants.dart';

class LevelsCollection {
  LevelModel? level;
  List<LevelModel> classicLevels = [];

  Future<List<LevelModel>> AddLevel() async {
    final prefs = await SharedPreferences.getInstance();

    level = LevelModel()
      ..number = 1
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_level1_key') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = levelsCollection['locked']
      ..periodOfTime = periodsCollection['cold_war'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 2
      ..questionCount = 10
      ..answeredCount = prefs.getInt('answers_level2_key') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = levelsCollection['unlocked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 3
      ..questionCount = 15
      ..answeredCount = prefs.getInt('answers_level3_key') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus = levelsCollection['passed']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 4
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_level4_key') ?? 0
      ..isPlane = true
      ..isTank = false
      ..isShip = true
      ..levelStatus = levelsCollection['starred']
      ..periodOfTime = periodsCollection['ww_2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 5
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_level5_key') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = levelsCollection['unlocked']
      ..periodOfTime = periodsCollection['cold_war'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 6
      ..questionCount = 10
      ..answeredCount = prefs.getInt('answers_level6_key') ?? 0
      ..isPlane = false
      ..isTank = true
      ..isShip = false
      ..levelStatus = levelsCollection['unlocked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 7
      ..questionCount = 15
      ..answeredCount = prefs.getInt('answers_level7_key') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus = levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 8
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_level8_key') ?? 0
      ..isPlane = true
      ..isTank = false
      ..isShip = true
      ..levelStatus = levelsCollection['locked']
      ..periodOfTime = periodsCollection['ww_2'];
    classicLevels.add(level!);

    return classicLevels;
  }
}
