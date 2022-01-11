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
      ..answeredCount = prefs.getInt('level1_answers') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = prefs.getString('level1_status') ?? levelsCollection['unlocked']
      ..periodOfTime = periodsCollection['cold_war'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 2
      ..questionCount = 10
      ..answeredCount = prefs.getInt('level2_answers') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = prefs.getString('level2_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 3
      ..questionCount = 15
      ..answeredCount = prefs.getInt('level3_answers') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus = prefs.getString('level3_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 4
      ..questionCount = 20
      ..answeredCount = prefs.getInt('level4_answers') ?? 0
      ..isPlane = true
      ..isTank = false
      ..isShip = true
      ..levelStatus = prefs.getString('level4_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['ww_2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 5
      ..questionCount = 5
      ..answeredCount = prefs.getInt('level5_answers') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = false
      ..levelStatus = prefs.getString('level5_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['cold_war'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 6
      ..questionCount = 10
      ..answeredCount = prefs.getInt('level6_answers') ?? 0
      ..isPlane = false
      ..isTank = true
      ..isShip = false
      ..levelStatus = prefs.getString('level6_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 7
      ..questionCount = 15
      ..answeredCount = prefs.getInt('level7_answers') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus = prefs.getString('level7_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    classicLevels.add(level!);

    level = LevelModel()
      ..number = 8
      ..questionCount = 20
      ..answeredCount = prefs.getInt('level8_answers') ?? 0
      ..isPlane = true
      ..isTank = false
      ..isShip = true
      ..levelStatus = prefs.getString('level8_status') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['ww_2'];
    classicLevels.add(level!);

    return classicLevels;
  }
}
