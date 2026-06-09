import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sasl/services/cacheService.dart';

void main() {
  group('CacheService Tests', () {
    late CacheService cacheService;

    setUp(() async {
      // Mock the initial values of SharedPreferences before every test
      SharedPreferences.setMockInitialValues({});
      cacheService = CacheService();
      await cacheService.initialize();
    });

    test('isDarkMode returns false by default', () {
      expect(cacheService.isDarkMode(), isFalse);
    });

    test('setDarkMode saves the value', () async {
      await cacheService.setDarkMode(true);
      expect(cacheService.isDarkMode(), isTrue);

      await cacheService.setDarkMode(false);
      expect(cacheService.isDarkMode(), isFalse);
    });

    test('hasCompletedDailyChallengeToday returns false by default', () {
      expect(cacheService.hasCompletedDailyChallengeToday(), isFalse);
    });

    test('markDailyChallengeCompleted updates the challenge state for today', () async {
      await cacheService.markDailyChallengeCompleted();
      expect(cacheService.hasCompletedDailyChallengeToday(), isTrue);
    });

    test('resetDailyChallenge clears the challenge state', () async {
      await cacheService.markDailyChallengeCompleted();
      expect(cacheService.hasCompletedDailyChallengeToday(), isTrue);

      await cacheService.resetDailyChallenge();
      expect(cacheService.hasCompletedDailyChallengeToday(), isFalse);
    });
  });
}
