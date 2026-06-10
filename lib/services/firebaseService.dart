import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../models/statsModel.dart';

/// Service quản lý toàn bộ kết nối Firebase:
/// - Firebase Authentication (đăng ký / đăng nhập / đăng xuất)
/// - Firebase Realtime Database (đọc / ghi stats của user)
class FirebaseService {
  // Singleton pattern — toàn app chỉ dùng 1 instance
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://sasl-app-9d8d3-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  // ─── Current User ─────────────────────────────────────────────

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;

  /// Lấy tên hiển thị của user (displayName hoặc phần trước @ của email)
  String get currentUsername {
    final displayName = _auth.currentUser?.displayName;
    return displayName ?? _auth.currentUser?.email?.split('@').first ?? '';
  }

  // ─── Auth: Register ───────────────────────────────────────────

  /// Đăng ký tài khoản mới.
  /// Trả về [null] nếu thành công, hoặc chuỗi thông báo lỗi nếu thất bại.
  Future<String?> register(String username, String password) async {
    try {
      // Firebase Auth yêu cầu email, nên ta tự động thêm một domain ảo (dummy domain) vào username.
      final dummyEmail = '${username.trim().toLowerCase()}@sasl.app';
      // Tạo tài khoản Firebase Auth
      final credential = await _auth.createUserWithEmailAndPassword(
        email: dummyEmail,
        password: password,
      );

      // Lưu tên hiển thị vào Firebase Auth profile
      await credential.user?.updateDisplayName(username.trim());

      // Khởi tạo dữ liệu profile và stats mặc định trong Realtime Database
      final uid = credential.user!.uid;
      await _db
          .ref('users/$uid/profile')
          .set({
            'username': username.trim(),
            'createdAt': DateTime.now().toIso8601String(),
          })
          .timeout(const Duration(seconds: 10));
      await _db
          .ref('users/$uid/stats')
          .set({
            'bestScore': 0,
            'currentStreak': 0,
            'lastPracticeDate': DateTime.now().toIso8601String(),
            'learnedSigns': [],
          })
          .timeout(const Duration(seconds: 10));

      return null; // thành công
    } on FirebaseAuthException catch (e) {
      // Chuyển mã lỗi Firebase sang thông báo tiếng Anh
      switch (e.code) {
        case 'email-already-in-use':
          return 'Username này đã được sử dụng. Vui lòng chọn username khác.';
        case 'invalid-email':
          return 'Username không hợp lệ (chỉ nên dùng chữ và số).';
        case 'weak-password':
          return 'Password is too weak. Minimum 6 characters required.';
        default:
          return 'Đã có lỗi xảy ra: ${e.message}';
      }
    } catch (e) {
      if (e is TimeoutException) {
        return 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng hoặc liên hệ Admin.';
      }
      return 'Unexpected error: $e';
    }
  }

  // ─── Auth: Login ──────────────────────────────────────────────

  /// Đăng nhập bằng username và mật khẩu.
  /// Trả về [null] nếu thành công, hoặc chuỗi thông báo lỗi nếu thất bại.
  Future<String?> login(String username, String password) async {
    try {
      final dummyEmail = '${username.trim().toLowerCase()}@sasl.app';
      await _auth.signInWithEmailAndPassword(
        email: dummyEmail,
        password: password,
      );
      return null; // thành công
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Username hoặc mật khẩu không đúng.';
        case 'invalid-email':
          return 'Username không hợp lệ.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'Login failed: ${e.message}';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // ─── Auth: Logout ─────────────────────────────────────────────

  /// Đăng xuất khỏi Firebase Auth.
  /// StreamBuilder trong main.dart sẽ tự chuyển về LoginScreen.
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ─── Stats: Get ───────────────────────────────────────────────

  /// Đọc stats của user hiện tại từ Realtime Database.
  /// Trả về [null] nếu chưa login hoặc chưa có dữ liệu.
  Future<StatsModel?> getStats() async {
    final uid = currentUser?.uid;
    if (uid == null) return null;

    try {
      final snapshot = await _db.ref('users/$uid/stats').get();
      if (!snapshot.exists) return null;

      final data = Map<String, dynamic>.from(snapshot.value as Map);

      // Firebase có thể lưu learnedSigns dạng List hoặc Map
      final learnedRaw = data['learnedSigns'];
      List<String> learned = [];
      if (learnedRaw is List) {
        learned = learnedRaw.whereType<String>().toList();
      } else if (learnedRaw is Map) {
        learned = learnedRaw.values.whereType<String>().toList();
      }

      return StatsModel(
        bestScore: (data['bestScore'] as num?)?.toInt() ?? 0,
        currentStreak: (data['currentStreak'] as num?)?.toInt() ?? 0,
        lastPracticeDate:
            DateTime.tryParse(data['lastPracticeDate'] ?? '') ?? DateTime.now(),
        learnedSigns: learned,
      );
    } catch (_) {
      return null;
    }
  }

  // ─── Stats: Save ──────────────────────────────────────────────

  /// Ghi toàn bộ stats vào Realtime Database (overwrite).
  Future<void> saveStats(StatsModel stats) async {
    final uid = currentUser?.uid;
    if (uid == null) return;

    try {
      await _db.ref('users/$uid/stats').set({
        'bestScore': stats.bestScore,
        'currentStreak': stats.currentStreak,
        'lastPracticeDate': stats.lastPracticeDate.toIso8601String(),
        'learnedSigns': stats.learnedSigns,
      });
    } catch (e) {
      debugPrint('Error saving stats: $e');
      rethrow; // Rethrow to let UI catch and show SnackBar
    }
  }

  // ─── Stats: Update Best Score ─────────────────────────────────

  /// Cập nhật điểm cao nhất nếu [score] vượt qua kỷ lục cũ.
  /// Dùng Firebase transaction để tránh race condition và không ghi đè data khác.
  Future<void> updateBestScore(int score) async {
    final uid = currentUser?.uid;
    if (uid == null) return;
    try {
      final ref = _db.ref('users/$uid/stats/bestScore');
      final snapshot = await ref.get();
      final currentBest = (snapshot.value as num?)?.toInt() ?? 0;
      if (score > currentBest) {
        await ref.set(score);
      }
    } catch (e) {
      debugPrint('Error updating best score: $e');
      rethrow;
    }
  }

  // ─── Stats: Update Streak ─────────────────────────────────────

  /// Cập nhật streak hàng ngày:
  /// - Cùng ngày → bỏ qua
  /// - Liên tiếp 1 ngày → tăng streak
  /// - Bỏ qua ≥ 2 ngày → reset về 1
  /// Chỉ cập nhật streak/lastPracticeDate, không đụng vào bestScore hay learnedSigns.
  Future<void> updateStreak() async {
    final uid = currentUser?.uid;
    if (uid == null) return;
    try {
      // Chỉ đọc streak và lastPracticeDate, tránh ghi đè toàn bộ stats
      final streakRef = _db.ref('users/$uid/stats/currentStreak');
      final dateRef = _db.ref('users/$uid/stats/lastPracticeDate');

      final streakSnap = await streakRef.get();
      final dateSnap = await dateRef.get();

      final currentStreak = (streakSnap.value as num?)?.toInt() ?? 0;
      final lastPracticeDate =
          DateTime.tryParse(dateSnap.value as String? ?? '') ?? DateTime(2000);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final lastPractice = DateTime(
        lastPracticeDate.year,
        lastPracticeDate.month,
        lastPracticeDate.day,
      );
      final daysDiff = today.difference(lastPractice).inDays;

      int newStreak;
      if (currentStreak == 0) {
        newStreak = 1; // lần đầu tiên / sau khi bị reset → bắt đầu đếm ngày 1
      } else if (daysDiff == 0) {
        return; // đã practice hôm nay rồi, không cần cập nhật
      } else if (daysDiff == 1) {
        newStreak = currentStreak + 1; // ngày liên tiếp → tiếp tục streak
      } else {
        newStreak =
            0; // bỏ ≥ 1 ngày → streak bị phá, reset về 0 (hôm nay không tính)
      }

      // Chỉ ghi 2 trường, không đụng vào bestScore/learnedSigns
      await streakRef.set(newStreak);
      await dateRef.set(now.toIso8601String());
    } catch (e) {
      debugPrint('Error updating streak: $e');
      rethrow;
    }
  }

  // ─── Stats: Add Learned Sign ──────────────────────────────────

  /// Thêm ký hiệu [sign] vào danh sách đã học (nếu chưa có).
  Future<void> addLearnedSign(String sign) async {
    final uid = currentUser?.uid;
    if (uid == null) return;
    try {
      // Chỉ đọc/ghi field learnedSigns, không đụng vào bestScore hay streak
      final ref = _db.ref('users/$uid/stats/learnedSigns');
      final snapshot = await ref.get();

      List<String> learned = [];
      final raw = snapshot.value;
      if (raw is List) {
        learned = raw.whereType<String>().toList();
      } else if (raw is Map) {
        learned = raw.values.whereType<String>().toList();
      }

      if (!learned.contains(sign)) {
        learned.add(sign);
        await ref.set(learned);
      }
    } catch (e) {
      debugPrint('Error adding learned sign: $e');
      rethrow;
    }
  }
}
