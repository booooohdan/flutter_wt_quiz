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
  String? levelStatus;
  String? periodOfTime;
}
