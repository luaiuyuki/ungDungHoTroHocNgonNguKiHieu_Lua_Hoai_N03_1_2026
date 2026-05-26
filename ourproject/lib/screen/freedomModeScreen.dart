import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class FreedomModeScreen extends BaseScreen {
  const FreedomModeScreen({super.key});

  @override
  String get title => 'Freedom Mode';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Freedom Mode Screen'));
  }
}
