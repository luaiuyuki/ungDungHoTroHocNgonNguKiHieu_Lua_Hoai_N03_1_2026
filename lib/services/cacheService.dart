import 'package:shared_preferences/shared_preferences.dart';

/// Service lưu trữ cài đặt cục bộ bằng SharedPreferences.
/// Chỉ quản lý UI settings — Auth và Stats đã chuyển sang FirebaseService.
class CacheService {
  // Cache instance để tránh gọi getInstance() nhiều lần
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Khởi tạo SharedPreferences khi app khởi động
  Future<void> initialize() async {
    await _instance;
  }

  // ─── Dark Mode ────────────────────────────────────────────────

  /// Trả về trạng thái dark mode hiện tại (mặc định: false)
  bool isDarkMode() {
    return _prefs?.getBool('darkMode') ?? false;
  }

  /// Lưu trạng thái dark mode
  Future<void> setDarkMode(bool value) async {
    final prefs = await _instance;
    await prefs.setBool('darkMode', value);
  }

  // ─── Daily Challenge ──────────────────────────────────────────

  /// Kiểm tra xem user đã hoàn thành Daily Challenge hôm nay chưa
  bool hasCompletedDailyChallengeToday() {
    final lastCompleted = _prefs?.getString('lastDailyChallengeDate');
    if (lastCompleted == null) return false;
    final lastDate = DateTime.tryParse(lastCompleted);
    if (lastDate == null) return false;
    final today = DateTime.now();
    return lastDate.year == today.year &&
        lastDate.month == today.month &&
        lastDate.day == today.day;
  }

  /// Đánh dấu Daily Challenge hôm nay đã hoàn thành
  Future<void> markDailyChallengeCompleted() async {
    final prefs = await _instance;
    await prefs.setString('lastDailyChallengeDate', DateTime.now().toIso8601String());
  }

  /// Xóa trạng thái Daily Challenge (dùng khi reset progress)
  Future<void> resetDailyChallenge() async {
    final prefs = await _instance;
    await prefs.remove('lastDailyChallengeDate');
  }

  // ─── Sound ────────────────────────────────────────────────────

  /// Trả về trạng thái sound effects (mặc định: bật)
  bool isSoundEnabled() {
    return _prefs?.getBool('soundEnabled') ?? true;
  }

  /// Bật / tắt sound effects
  Future<void> setSoundEnabled(bool value) async {
    final prefs = await _instance;
    await prefs.setBool('soundEnabled', value);
  }

  // ─── Tutorial ─────────────────────────────────────────────────

  /// Kiểm tra xem user đã xem tutorial của màn hình [modeKey] chưa
  bool hasSeenTutorial(String modeKey) {
    final key = 'tutorial${modeKey[0].toUpperCase()}${modeKey.substring(1)}';
    return _prefs?.getBool(key) ?? false;
  }

  /// Đánh dấu tutorial của màn hình [modeKey] đã xem
  Future<void> markTutorialSeen(String modeKey) async {
    final prefs = await _instance;
    final key = 'tutorial${modeKey[0].toUpperCase()}${modeKey.substring(1)}';
    await prefs.setBool(key, true);
  }
}

/// Global singleton — dùng trực tiếp khắp app: `cacheService.isDarkMode()`
final cacheService = CacheService();