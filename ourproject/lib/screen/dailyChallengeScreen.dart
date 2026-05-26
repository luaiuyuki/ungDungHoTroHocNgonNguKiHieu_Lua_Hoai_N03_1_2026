import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class DailyChallengeScreen extends BaseScreen {
  const DailyChallengeScreen({super.key});

  @override
  String get title => 'Daily Challenge';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Daily Challenge Screen'));
  }
}
