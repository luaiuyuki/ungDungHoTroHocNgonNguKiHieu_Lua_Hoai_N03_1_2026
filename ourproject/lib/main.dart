import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SASL Project -c',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const MainNavigation(),
    );
  }
}

// Cấu trúc Bottom Navigation Bar
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Danh sách các màn hình
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ContentScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Content'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ---------------------------------------------------------
// WIDGET DÙNG CHUNG CHO HEADER & FOOTER (Đúng yêu cầu cô)
// ---------------------------------------------------------

class CommonLayout extends StatelessWidget {
  final Widget content;
  const CommonLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. HEADER: Image of Group Student
        Container(
          width: double.infinity,
          height: 150,
          child: Image.network(
            "https://static.wixstatic.com/media/41a9b2_372cd6c5757f47479be1577541a08d7b~mv2.png/v1/fill/w_980,h_551,al_c,q_90,usm_0.66_1.00_0.01,enc_avif,quality_auto/41a9b2_372cd6c5757f47479be1577541a08d7b~mv2.png",
            fit: BoxFit.cover,
          ),
        ),

        // 2. BODY: Content (Dùng Expanded để chiếm phần còn lại)
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: const Text("nội dung ") ,
          ),
        ),

        // 3. FOOTER: Phenikaa University, Student Name
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Colors.deepPurple[50],
          child: const Column(
            children: [
              Text("Phenikaa University",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Student: Đặng Thị Thu Hoai - 23010316"),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// CÁC MÀN HÌNH CỤ THỂ
// ---------------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CommonLayout(
      content: Column(
        children: [
          Text("abcd ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Card(child: ListTile(title: Text("Tiến độ học tập: 15 ký hiệu"))),
        ],
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu liên quan đến nhận diện ngôn ngữ ký hiệu
    final List<Map<String, dynamic>> detectionHistory = [
      {'label': 'Xin chào', 'conf': 0.98, 'status': 'Thành công'},
      {'label': 'Cảm ơn', 'conf': 0.92, 'status': 'Thành công'},
      {'label': 'Hẹn gặp lại', 'conf': 0.75, 'status': 'Cần thử lại'},
      {'label': 'Tôi yêu bạn', 'conf': 0.99, 'status': 'Thành công'},
    ];

    return CommonLayout(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "LỊCH SỬ NHẬN DIỆN AI",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),

          // Danh sách các kết quả nhận diện
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detectionHistory.length,
            itemBuilder: (context, index) {
              final item = detectionHistory[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    child:
                        const Icon(Icons.front_hand, color: Colors.deepPurple),
                  ),
                  title: Text("Ký hiệu: ${item['label']}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "Độ tin cậy: ${(item['conf'] * 100).toStringAsFixed(0)}%"),
                  trailing: Icon(
                    item['status'] == 'Thành công'
                        ? Icons.check_circle
                        : Icons.error,
                    color: item['status'] == 'Thành công'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const CommonLayout(
      content: Center(
        child: Text("Dự án hỗ trợ học ngôn ngữ ký hiệu2"),
      ),
    );
  }
}
