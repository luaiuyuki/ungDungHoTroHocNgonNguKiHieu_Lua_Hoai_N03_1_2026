import 'package:flutter_test/flutter_test.dart';
import 'package:sasl/models/statsModel.dart';

void main() {
  group('StatsModel Tests', () {
    test('Should initialize correctly with given values', () {
      final date = DateTime(2026, 6, 9);
      final stats = StatsModel(
        bestScore: 100,
        currentStreak: 5,
        lastPracticeDate: date,
        learnedSigns: ['A', 'B', 'C'],
      );

      expect(stats.bestScore, 100);
      expect(stats.currentStreak, 5);
      expect(stats.lastPracticeDate, date);
      expect(stats.learnedSigns, ['A', 'B', 'C']);
      expect(stats.learnedSigns.length, 3);
    });

    test('Should allow updating mutable fields', () {
      final stats = StatsModel(
        bestScore: 0,
        currentStreak: 0,
        lastPracticeDate: DateTime.now(),
        learnedSigns: [],
      );

      stats.bestScore = 50;
      stats.currentStreak = 1;
      stats.learnedSigns.add('D');

      expect(stats.bestScore, 50);
      expect(stats.currentStreak, 1);
      expect(stats.learnedSigns.contains('D'), isTrue);
    });
  });
}
