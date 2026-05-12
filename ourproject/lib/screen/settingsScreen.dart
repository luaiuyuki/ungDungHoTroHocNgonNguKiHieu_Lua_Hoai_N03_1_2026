import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Biến lưu trữ trạng thái của Switch (để lấy dữ liệu)
  bool _enableVibration = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt (Settings)')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Đối tượng SwitchListTile (Bao gồm chữ và nút công tắc)
          SwitchListTile(
            title: const Text('Bật chế độ rung (Vibration)'),
            subtitle: const Text('Phản hồi rung khi làm đúng bài tập ký hiệu'),
            value: _enableVibration,
            onChanged: (bool value) {
              // GET VALUE (Lấy dữ liệu) Ở ĐÂY
              print("Trạng thái rung được thay đổi thành: $value");

              setState(() {
                _enableVibration = value; // Cập nhật lại giao diện
              });
            },
            activeColor: Theme.of(context).primaryColor,
          ),

          const Divider(height: 32),

          // 2. Đối tượng Slider (Thanh trượt) - Dành cho 1 bạn sinh viên khác
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Tốc độ phát video bài giảng',
                style: TextStyle(fontSize: 16)),
          ),
          Slider(
            value: 1.0, // Giá trị mặc định (Ví dụ cần dùng state thật thì đổi)
            min: 0.5,
            max: 2.0,
            divisions: 3,
            label: '1.0x',
            onChanged: (double value) {
              // YÊU CẦU A: GET VALUE (Lấy dữ liệu) CỦA SLIDER Ở ĐÂY
              print("Tốc độ video được chọn là: ${value}x");
              // Trong thực tế sẽ gọi setState để cập nhật biến
            },
          ),
        ],
      ),
    );
  }
}
