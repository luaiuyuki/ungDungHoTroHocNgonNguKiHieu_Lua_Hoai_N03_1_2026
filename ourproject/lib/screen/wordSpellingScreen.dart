import 'package:flutter/material.dart';

class WordSpellingScreen extends StatelessWidget {
  const WordSpellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Spelling')),
      body: const Center(child: Text('Word Spelling Screen')),
    );
  }
}
