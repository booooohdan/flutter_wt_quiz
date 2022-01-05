import 'package:flutter/foundation.dart';

import '../models/level.dart';

class LevelProvider with ChangeNotifier{
  late Level _level;
  Level get currentLevel => _level;

  void changeLevel(Level level) {
    _level = level;
    notifyListeners();
  }

}