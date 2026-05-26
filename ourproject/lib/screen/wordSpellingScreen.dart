import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class WordSpellingScreen extends BaseScreen {
  const WordSpellingScreen({super.key});

  @override
  String get title => 'Word Spelling';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Word Spelling Screen'));
  }
}
