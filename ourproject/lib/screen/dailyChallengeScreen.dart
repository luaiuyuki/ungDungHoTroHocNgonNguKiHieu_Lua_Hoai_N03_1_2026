import 'package:flutter/material.dart';

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Challenge')),
      body: const Center(
        child: Text('Daily Challenge Screen'),
      ),
    );
  }
}
