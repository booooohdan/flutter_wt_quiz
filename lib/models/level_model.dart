class LevelModel {
  LevelModel(
      {this.name,
      this.number,
      this.questionCount,
      this.answeredCount,
      this.isPlane = false,
      this.isTank = false,
      this.isShip = false,
      this.levelStatus,
      this.levelType = 'Classic',
      this.periodOfTime});

  String? name;
  int? number;
  int? questionCount;
  int? answeredCount;
  bool? isPlane;
  bool? isTank;
  bool? isShip;
  String? levelStatus;
  String? levelType;
  String? periodOfTime;
}
