import 'package:flutter/material.dart';

class TestModeScreen extends StatelessWidget {
  const TestModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Mode')),
      body: const Center(child: Text('Test Mode Screen')),
    );
  }
}
