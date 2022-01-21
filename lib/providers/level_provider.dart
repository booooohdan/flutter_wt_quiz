import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/debug_levels_collection.dart';
import '../data/levels_collection.dart';
import '../models/level_model.dart';

class LevelProvider with ChangeNotifier {
  late LevelModel _level;

  LevelModel get currentLevel => _level;

  void setLevel(LevelModel level) {
    _level = level;
    notifyListeners();
  }

  Future saveResultToPreferences(
      double correctToTotalRatio, int correctAnswersCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('answers_${currentLevel.id}', correctAnswersCount);

    if (correctToTotalRatio >= 0.9) {
      await prefs.setString('status_${currentLevel.id}', 'level_passed');
      await prefs.setString('status_${currentLevel.id! + 1}', 'level_unlocked');
    }
    if (correctToTotalRatio == 1.0) {
      await prefs.setString('status_${currentLevel.id}', 'level_starred');
      await prefs.setString('status_${currentLevel.id! + 1}', 'level_unlocked');
    }
    notifyListeners();
  }

  Future<List<LevelModel>> addLevels(String args) async {
    if (kDebugMode) {
      switch (args) {
        case 'HARDCORE':
          return await DebugLevelsCollection().addHardcoreLevel();
        case 'TRAINING':
          return await DebugLevelsCollection().addTrainingLevel();
        default:
          return await DebugLevelsCollection().addClassicLevel();
      }
    } else {
      //FIXME: Comment code below if dart file isn't found and add "return await DebugLevelsCollection().addClassicLevel();"
      switch (args) {
        case 'HARDCORE':
          return await LevelsCollection().addHardcoreLevel();
        case 'TRAINING':
          return await LevelsCollection().addTrainingLevel();
        default:
          return await LevelsCollection().addClassicLevel();
      }
    }
  }
}
