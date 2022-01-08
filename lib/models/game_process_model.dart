class GameProcessModel {
  GameProcessModel({
    this.correctAnswersCount =0,
    this.heartsCount = 0,
    this.questionCurrent = 0,
    this.questionsTotal = 0,
    this.timeCurrent = 0,
    this.timeAverage = 0,
    this.timeExpected = 0,
    this.hintFiftyFifty = 0,
    this.hintNation = 0,
    this.hintSkip = 0,
  });

  int correctAnswersCount;
  int heartsCount;
  int questionCurrent;
  int questionsTotal;
  int timeCurrent;
  int timeAverage;
  int timeExpected;
  int hintFiftyFifty;
  int hintNation;
  int hintSkip;
}
