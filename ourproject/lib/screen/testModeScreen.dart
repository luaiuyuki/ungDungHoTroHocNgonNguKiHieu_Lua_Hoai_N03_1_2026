import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class TestModeScreen extends BaseScreen {
  const TestModeScreen({super.key});

  @override
  String get title => 'Test Mode';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Test Mode Screen'));
  }
}
