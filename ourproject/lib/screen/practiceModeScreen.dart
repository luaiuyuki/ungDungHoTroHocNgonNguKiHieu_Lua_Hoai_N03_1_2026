import 'package:flutter/material.dart';
import 'baseScreen.dart';

/// LỚP CHUYÊN BIỆT HÓA (Specialization)
/// Kế thừa từ lớp tổng quát BaseScreen, tái sử dụng được Scaffold và AppBar
class PracticeModeScreen extends BaseScreen {
  const PracticeModeScreen({super.key});

  // Chuyên biệt hóa thuộc tính title
  @override
  String get title => 'Practice Mode';

  // Chuyên biệt hóa phần nội dung giao diện riêng của màn hình này
  @override
  Widget buildBody(BuildContext context) {
    return const Center(child: Text('Practice Mode Screen'));
  }
}
