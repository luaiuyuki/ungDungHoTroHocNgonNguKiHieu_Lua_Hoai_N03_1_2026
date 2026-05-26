// lib/user_model.dart
import 'package:flutter/foundation.dart';

import 'models/base_model.dart';

class User extends BaseModel<int> {
  String level;
  int totalPoints;

  User({
    required int uid,
    required String displayName,
    required String description,
    required this.level,
    required this.totalPoints,
  }) : super(
          id: uid,
          title: displayName,
          description: description,
        );

  @override
  void showInfo() {
    debugPrint("User ID: $id | "
        "Tên: $title | "
        "Level: $level | "
        "Points: $totalPoints");
  }
}
