import 'package:flutter/material.dart';

class PracticeModeScreen extends StatelessWidget {
  const PracticeModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Mode')),
      body: const Center(child: Text('Practice Mode Screen')),
    );
  }
}
