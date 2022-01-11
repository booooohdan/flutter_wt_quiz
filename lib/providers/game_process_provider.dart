import 'package:flutter/foundation.dart';

import '../models/game_process_model.dart';


class GameProcessProvider with ChangeNotifier {
  late GameProcessModel _gameProcessModel;

  GameProcessModel get currentGameProcess => _gameProcessModel;

  void setGameProcess(GameProcessModel gameProcessModel) {
    _gameProcessModel = gameProcessModel;
    notifyListeners();
  }
}
