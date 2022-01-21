class LevelModel {
  LevelModel(
      {this.name,
      this.id,
      this.questionCount,
      this.answeredCount,
      this.isPlane = false,
      this.isTank = false,
      this.isShip = false,
      this.levelStatus,
      this.levelType = 'Classic',
      this.periodOfTime});

  String? name;
  int? id;
  int? questionCount;
  int? answeredCount;
  bool? isPlane;
  bool? isTank;
  bool? isShip;
  String? levelStatus;
  String? levelType;
  String? periodOfTime;
}
