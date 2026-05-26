import 'package:flutter/material.dart';

/// LỚP TỔNG QUÁT HÓA (Generalization)
/// Đây là lớp cơ sở (Base Class) đại diện cho một màn hình chung trong ứng dụng.
/// Các màn hình cụ thể sẽ kế thừa lớp này để tái sử dụng cấu trúc giao diện Scaffold, AppBar...
abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  /// Thuộc tính trừu tượng: Lớp con (chuyên biệt) bắt buộc phải cung cấp tiêu đề riêng
  String get title;

  /// Phương thức trừu tượng: Lớp con bắt buộc phải tự thiết kế nội dung (body) riêng
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // Phần Tổng Quát: Khung giao diện chung áp dụng cho mọi màn hình kế thừa
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: buildBody(context), // Gọi đến phần chuyên biệt của lớp con
    );
  }
}
