import 'package:flutter/foundation.dart';

import '../models/level_model.dart';

class LevelProvider with ChangeNotifier {
  late LevelModel _level;

  LevelModel get currentLevel => _level;

  void setLevel(LevelModel level) {
    _level = level;
    notifyListeners();
  }
}
