import '../models/level_status.dart';
import '../models/period_of_time.dart';

class Level {
  Level(
      {this.number,
      this.questionCount,
      this.answeredCount,
      this.isPlane,
      this.isTank,
      this.isShip,
      this.levelStatus,
      this.periodOfTime
      });

  int? number;
  int? questionCount;
  int? answeredCount;
  bool? isPlane;
  bool? isTank;
  bool? isShip;
  LevelStatus? levelStatus;
  PeriodOfTime? periodOfTime;
}
