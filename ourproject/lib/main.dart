import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng hỗ trợ học ngôn ngữ kí hiệu',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tiến độ học tập'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Dữ liệu người dùng
    var listUser = {'name': 'Nguyễn Thị Lụa', 'createdAt': '15/04/2026'};
    
    // Dữ liệu thống kê
    var listLearningStatistics = {
      'bestScore': 130,
      'currentSteak': 7,
      'lastPraticeDate': '10/4/2026',
      'learnedSigns': [
        'Xin chào', 'Cảm ơn', 'Gia đình', 'Tạm biệt', 'Yêu thương', 'Xin lỗi'
      ]
    };

    // Ép kiểu mảng ký hiệu để sử dụng trong Map
    final signs = listLearningStatistics['learnedSigns'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: <Widget>[
        
            const Text(
              '1. Thông tin người học:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            ),
            const SizedBox(height: 8),
            Card( 
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: Text('Họ và tên: ${listUser['name']}'),
                subtitle: Text('Ngày tham gia: ${listUser['createdAt']}'), 
              ),
            ),
            
            const Divider(height: 40, thickness: 1.5),

            // 2. Thống kê học tập
            const Text(
              '2. Thống kê học tập:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 12),
            
            // Hiển thị các chỉ số nhanh
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Điểm cao", "${listLearningStatistics['bestScore']}"),
                _buildStatItem("Chuỗi ngày", "${listLearningStatistics['currentSteak']} 🔥"),
              ],
            ),
            
            const SizedBox(height: 20),
            const Text(
              'Các ký hiệu đã thuộc:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

           
            Wrap(
              spacing: 8.0, 
              runSpacing: 4.0,
              children: signs.map((sign) => Chip(
                label: Text(sign),
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget phụ trợ để hiển thị chỉ số cho gọn code
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
