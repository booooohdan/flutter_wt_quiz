import 'package:flutter/foundation.dart';

import '../data/debug_planes_collection.dart';
import '../data/planes_collection.dart';
import '../models/game_process_model.dart';
import '../models/level_model.dart';
import '../models/vehicle_model.dart';
import '../utilities/constants.dart';

class GameProcessProvider with ChangeNotifier {
  late GameProcessModel _gameProcessModel;

  GameProcessModel get currentGameProcess => _gameProcessModel;

  void setGameProcess(GameProcessModel gameProcessModel) {
    _gameProcessModel = gameProcessModel;
    notifyListeners();
  }

  GameProcessModel? setLevelDifficultParams(LevelModel level) {
    if (level.levelType == levelTypes['classic']) {
      return GameProcessModel()
        ..heartsCount = 3
        ..questionsTotal = level.questionCount!
        ..timeExpected = 10
        ..hintFiftyFifty = 1
        ..hintNation = 1
        ..hintSkip = 1;
    }

    if (level.levelType == levelTypes['hardcore']) {
      return GameProcessModel()
        ..heartsCount = 1
        ..questionsTotal = level.questionCount!
        ..timeExpected = 5
        ..hintFiftyFifty = 1
        ..hintNation = 1
        ..hintSkip = 1;
    }

    if (level.levelType == levelTypes['insane']) {
      return GameProcessModel()
        ..heartsCount = 1
        ..questionsTotal = level.questionCount!
        ..timeExpected = 3
        ..hintFiftyFifty = 0
        ..hintNation = 0
        ..hintSkip = 0;
    }

    if (level.levelType == levelTypes['training']) {
      return GameProcessModel()
        ..heartsCount = level.questionCount!
        ..questionsTotal = level.questionCount!
        ..timeExpected = 10
        ..hintFiftyFifty = level.questionCount!
        ..hintNation = level.questionCount!
        ..hintSkip = level.questionCount!;
    }
  }

  List<VehicleModel> addVehicles(LevelModel level) {
    // ignore: prefer_final_locals
    List<VehicleModel> vehicles = [];
    if (kDebugMode) {
      if (level.isPlane!) {
        vehicles.addAll(debugPlanes);
      }
      if (level.isTank!) {
        //vehicles.addAll(tanks);
      }
      if (level.isTank!) {
        //vehicles.addAll(ships);
      }
      return vehicles;
    } else {
      if (level.isPlane!) {
        vehicles.addAll(planes);
      }
      if (level.isTank!) {
        //vehicles.addAll(tanks);
      }
      if (level.isTank!) {
        //vehicles.addAll(ships);
      }
      return vehicles;
    }
  }
}
