class StatsModel {
  final int bestScore;
  final int currentStreak;
  final DateTime lastPracticeDate;
  final List<String> learnedSigns;

  StatsModel({
    required this.bestScore,
    required this.currentStreak,
    required this.lastPracticeDate,
    required this.learnedSigns,
  });

  factory StatsModel.empty() {
    return StatsModel(
      bestScore: 0,
      currentStreak: 0,
      lastPracticeDate: DateTime.now(),
      learnedSigns: [],
    );
  }
}
