import 'package:flutter/foundation.dart';

import '../data/debug_planes_collection.dart';
import '../data/debug_ships_collection.dart';
import '../data/debug_tanks_collection.dart';
import '../data/planes_collection.dart';
import '../data/ships_collection.dart';
import '../data/tanks_collection.dart';
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

    if (level.isPlane! && level.periodOfTime == 'Pre-WWII') {
      vehicles.addAll(
          planes.where((element) => element.periodOfTime == 'Pre-WWII'));
    }
    if (level.isPlane! && level.periodOfTime == 'World War II') {
      vehicles.addAll(
          planes.where((element) => element.periodOfTime == 'World War II'));
    }
    if (level.isPlane! && level.periodOfTime == 'Cold War') {
      vehicles.addAll(
          planes.where((element) => element.periodOfTime == 'Cold War'));
    }
    if (level.isPlane! && level.periodOfTime == 'All times') {
      vehicles.addAll(planes);
    }

    if (level.isTank! && level.periodOfTime == 'Pre-WWII') {
      vehicles
          .addAll(tanks.where((element) => element.periodOfTime == 'Pre-WWII'));
    }
    if (level.isTank! && level.periodOfTime == 'World War II') {
      vehicles.addAll(
          tanks.where((element) => element.periodOfTime == 'World War II'));
    }
    if (level.isTank! && level.periodOfTime == 'Cold War') {
      vehicles
          .addAll(tanks.where((element) => element.periodOfTime == 'Cold War'));
    }
    if (level.isTank! && level.periodOfTime == 'All times') {
      vehicles.addAll(tanks);
    }

    if (level.isShip! && level.periodOfTime == 'Pre-WWII') {
      vehicles
          .addAll(ships.where((element) => element.periodOfTime == 'Pre-WWII'));
    }
    if (level.isShip! && level.periodOfTime == 'World War II') {
      vehicles.addAll(
          ships.where((element) => element.periodOfTime == 'World War II'));
    }
    if (level.isShip! && level.periodOfTime == 'Cold War') {
      vehicles
          .addAll(ships.where((element) => element.periodOfTime == 'Cold War'));
    }
    if (level.isShip! && level.periodOfTime == 'All times') {
      vehicles.addAll(ships);
    }

    return vehicles;

    //FIXME: Comment "if section" above, and uncomment below if dart file isn't found

    // if (level.isPlane!) {
    //   vehicles.addAll(debugPlanes);
    // }
    // if (level.isTank!) {
    //   vehicles.addAll(debugTanks);
    // }
    // if (level.isShip!) {
    //   vehicles.addAll(debugShips);
    // }
    // return vehicles;
  }
}
