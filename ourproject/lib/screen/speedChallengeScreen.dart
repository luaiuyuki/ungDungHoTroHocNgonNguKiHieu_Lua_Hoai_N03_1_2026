import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
class SpeedChallengeScreen extends BaseScreen {
  const SpeedChallengeScreen({super.key});

  @override
  String get title => 'Speed Challenge';

  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Speed Challenge Screen'));
  }
}
