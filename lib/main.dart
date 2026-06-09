import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/cacheService.dart';
import 'screens/mainShell.dart';
import 'screens/loginScreen.dart';

// Màu chính của app
const kBrandPurple = Color(0xFF9C27B0);
const kBrandPurpleDark = Color(0xFFCE93D8);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi tạo Firebase trước khi chạy app
  await Firebase.initializeApp();
  // Khởi tạo SharedPreferences để đọc settings ngay từ đầu
  await cacheService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  /// Cho phép các widget con gọi MyApp.of(context)?.rebuildApp()
  /// để rebuild toàn app (dùng khi đổi dark mode)
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Gọi method này để rebuild lại toàn bộ MaterialApp (đổi theme)
  void rebuildApp() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isDark = cacheService.isDarkMode();

    return MaterialApp(
      title: 'SASL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        primaryColor: kBrandPurple,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        primaryColor: kBrandPurpleDark,
        useMaterial3: true,
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      // StreamBuilder lắng nghe trạng thái đăng nhập Firebase
      // Tự động điều hướng giữa LoginScreen và MainShell
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Đang chờ kết quả từ Firebase
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // Đã đăng nhập → vào MainShell
          if (snapshot.hasData && snapshot.data != null) {
            return const MainShell();
          }
          // Chưa đăng nhập → vào LoginScreen
          return const LoginScreen();
        },
      ),
    );
  }
}