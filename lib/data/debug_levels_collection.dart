import 'package:shared_preferences/shared_preferences.dart';

import '../models/level_model.dart';
import '../utilities/constants.dart';

class DebugLevelsCollection {
  LevelModel? level;
  List<LevelModel> levels = [];

  Future<List<LevelModel>> addClassicLevel() async {
    final prefs = await SharedPreferences.getInstance();

    level = LevelModel()
      ..name = 'Level 1'
      ..number = 1
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_1') ?? 0
      ..isPlane = true
      ..levelStatus =
          prefs.getString('status_1') ?? levelsCollection['unlocked']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 2'
      ..number = 2
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_2') ?? 0
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_2') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 3'
      ..number = 3
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_3') ?? 0
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_3') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 4'
      ..number = 4
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_4') ?? 0
      ..isPlane = true
      ..levelStatus =
          prefs.getString('status_4') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['ww_2'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 5'
      ..number = 5
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_5') ?? 0
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_5') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['cold_war'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 6'
      ..number = 6
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_6') ?? 0
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_6') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['pre_ww2'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 7'
      ..number = 7
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_7') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_7') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Level 8'
      ..number = 8
      ..questionCount = 5
      ..answeredCount = prefs.getInt('answers_8') ?? 0
      ..isPlane = true
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_8') ?? levelsCollection['locked']
      ..periodOfTime = periodsCollection['cold_war'];
    levels.add(level!);

    return levels;
  }

  Future<List<LevelModel>> addHardcoreLevel() async {
    final prefs = await SharedPreferences.getInstance();

    level = LevelModel()
      ..name = 'Hardcore Lite 😓'
      ..number = 10001
      ..questionCount = 100
      ..answeredCount = prefs.getInt('answers_10001') ?? 0
      ..isPlane = true
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_10001') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['hardcore']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Hardcore 💪'
      ..number = 10002
      ..questionCount = 100
      ..answeredCount = prefs.getInt('answers_10002') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_10002') ?? levelsCollection['locked']
      ..levelType = levelTypes['hardcore']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = '💀 INSANE 💀'
      ..number = 10003
      ..questionCount = 1000
      ..answeredCount = prefs.getInt('answers_10003') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_10003') ?? levelsCollection['locked']
      ..levelType = levelTypes['insane']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    return levels;
  }

  Future<List<LevelModel>> addTrainingLevel() async {
    final prefs = await SharedPreferences.getInstance();

    level = LevelModel()
      ..name = 'Only Planes'
      ..number = 1001
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1001') ?? 0
      ..isPlane = true
      ..levelStatus =
          prefs.getString('status_1001') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Only Tanks'
      ..number = 1002
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1002') ?? 0
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_1001') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Only Ships'
      ..number = 1003
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1003') ?? 0
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_1003') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['all_times'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Only Pre-WWII'
      ..number = 1004
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1004') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_1004') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['pre_ww2'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Only WWII'
      ..number = 1005
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1005') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_1005') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['ww_2'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Only Cold War'
      ..number = 1006
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1006') ?? 0
      ..isPlane = true
      ..isTank = true
      ..isShip = true
      ..levelStatus =
          prefs.getString('status_1006') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['cold_war'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Tank and Planes'
      ..number = 1007
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1007') ?? 0
      ..isPlane = true
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_1007') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['ww_2'];
    levels.add(level!);

    level = LevelModel()
      ..name = 'Tank and Planes'
      ..number = 1008
      ..questionCount = 20
      ..answeredCount = prefs.getInt('answers_1008') ?? 0
      ..isPlane = true
      ..isTank = true
      ..levelStatus =
          prefs.getString('status_1008') ?? levelsCollection['unlocked']
      ..levelType = levelTypes['training']
      ..periodOfTime = periodsCollection['cold_war'];
    levels.add(level!);



    return levels;
  }
}
