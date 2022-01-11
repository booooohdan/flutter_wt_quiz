import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/level_model.dart';

class LevelProvider with ChangeNotifier {
  late LevelModel _level;

  LevelModel get currentLevel => _level;

  void setLevel(LevelModel level) {
    _level = level;
    notifyListeners();
  }

  Future saveResultToPreferences(double correctToTotalRatio, int correctAnswersCount) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level${currentLevel.number}_answers', correctAnswersCount);

    if(correctToTotalRatio>= 0.9){
      await prefs.setString('level${currentLevel.number}_status', 'level_passed');
      await prefs.setString('level${currentLevel.number!+1}_status', 'level_unlocked');
    }
    if(correctToTotalRatio == 1.0){
      await prefs.setString('level${currentLevel.number}_status', 'level_starred');
      await prefs.setString('level${currentLevel.number!+1}_status', 'level_unlocked');
    }
    notifyListeners();
  }
}
