/// Model lưu thống kê học tập của user.
/// Được đọc từ / ghi vào Firebase Realtime Database qua FirebaseService.
class StatsModel {
  int bestScore;
  int currentStreak;
  DateTime lastPracticeDate;
  List<String> learnedSigns;

  StatsModel({
    required this.bestScore,
    required this.currentStreak,
    required this.lastPracticeDate,
    required this.learnedSigns,
  });
}
