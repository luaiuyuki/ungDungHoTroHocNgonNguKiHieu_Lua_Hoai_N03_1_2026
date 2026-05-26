import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class DictionaryScreen extends BaseScreen {
  const DictionaryScreen({super.key});

  @override
  String get title => 'Dictionary';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Dictionary Screen'));
  }
}
