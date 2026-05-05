import 'package:flutter/material.dart';
import 'screen/onboardingScreen.dart';

const kBrandPurple = Color(0xFF9C27B0);
const kBrandPurpleDark = Color(0xFFCE93D8);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      themeMode: ThemeMode.light,
      home: const OnboardingScreen(),
    );
  }
}