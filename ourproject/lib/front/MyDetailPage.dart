import 'package:flutter/material.dart';

class MyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stats = {
      'bestScore': 130,
      'currentSteak': 7,
      'lastPraticeDate': '10/4/2026',
      'learnedSigns': [
        'Xin chào', 'Cảm ơn', 'Gia đình', 'Tạm biệt', 'Yêu thương', 'Xin lỗi'
      ]
    };

    return SingleChildScrollView( 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thống kê học tập",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

         
          Row(
            children: [
              _buildStatCard("Điểm cao nhất", stats['bestScore'].toString(), Colors.orange),
              const SizedBox(width: 10),
              _buildStatCard("Chuỗi ngày", "${stats['currentSteak']} ngày", Colors.green),
            ],
          ),
          const SizedBox(height: 20),

          // 3. Ngày luyện tập cuối
          Text("Lần tập cuối: ${stats['lastPraticeDate']}", 
               style: const TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 25),

          // 4. Danh sách các từ đã học (Dùng Wrap để tự xuống dòng)
          const Text("Các từ đã thuộc:", 
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0, // Khoảng cách giữa các nhãn ngang
            runSpacing: 4.0, // Khoảng cách giữa các hàng
            children: (stats['learnedSigns'] as List<String>).map((sign) {
              return Chip(
                label: Text(sign),
                backgroundColor: Colors.purple[50],
                side: BorderSide(color: Colors.purple.shade100),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Hàm phụ để tạo các ô số liệu cho nhanh và đẹp
  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}