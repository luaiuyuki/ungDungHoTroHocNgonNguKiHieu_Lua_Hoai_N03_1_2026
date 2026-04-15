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
      home: const MyHomePage(title: 'Ứng dụng hỗ trợ ngôn ngữ kí hiệu'),
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
  int _counter = 0;

  // ==========================================================
  // CÂU 1: XÁC ĐỊNH ĐỐI TƯỢNG VÀ CÁC BIẾN MÔ TẢ
  // ==========================================================
  String name = "Đặng Thị Thu Hoài";
  String mssv = "23010316";
  String lop = "N03";
  int totalSigns = 15;        // Tổng số ký hiệu đã học
  double accuracy = 0.92;     // Độ chính xác trung bình
  String label = "Cảm ơn";    // Kết quả nhận diện hiện tại
  double confidence = 0.95;   // Độ tin cậy AI

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ==========================================================
    // CÂU 2: SỬ DỤNG COLLECTIONS (LIST, MAP)
    // ==========================================================
    // 2.1 Map thông tin cá nhân
    Map<String, dynamic> userProfile = {
      'ten': name,
      'id': mssv,
      'lopHoc': lop,
    };

    // 2.2 List chứa các Map danh sách ký hiệu
    List<Map<String, dynamic>> signHistory = [
      {'sign': label, 'score': confidence, 'status': 'Đạt'},
      {'sign': 'Xin chào', 'score': 0.88, 'status': 'Đạt'},
      {'sign': 'Hẹn gặp lại', 'score': 0.75, 'status': 'Cần cố gắng'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // ==========================================================
              // CÂU 3: HIỂN THỊ DỮ LIỆU RA MÀN HÌNH (ROW, COLUMN)
              // ==========================================================
              
              // 3.1 Sử dụng ROW để hiển thị thông tin học viên
              Card(
                color: Colors.deepPurple.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Học viên: ${userProfile['ten']}", 
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Lớp: ${userProfile['lopHoc']}"),
                        ],
                      ),
                      Text("MSSV: ${userProfile['id']}", 
                        style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              
              // Hiển thị biến đơn và Counter
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Số ký hiệu đã học: $totalSigns', style: const TextStyle(fontSize: 16)),
                    Text('Tỉ lệ chính xác: ${(accuracy * 100).toStringAsFixed(1)}%', 
                      style: const TextStyle(fontSize: 16, color: Colors.blue)),
                    const Divider(),
                    const Text('Bạn đã tương tác (nhấn nút):', style: TextStyle(fontSize: 14)),
                    Text('$_counter lần', 
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.deepPurple)),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("LỊCH SỬ NHẬN DIỆN", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple)),
              ),
              
              const SizedBox(height: 10),

              // 3.2 Sử dụng COLUMN và MAP để hiển thị danh sách từ Collection
              Column(
                children: signHistory.map((item) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.front_hand, size: 20),
                      ),
                      title: Text("Ký hiệu: ${item['sign']}", 
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Độ tin cậy: ${(item['score'] * 100).toStringAsFixed(0)}%"),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: item['status'] == 'Đạt' ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(item['status'], 
                          style: TextStyle(
                            color: item['status'] == 'Đạt' ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                          )),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 30),
              const Text('Dự án: Hỗ trợ ngôn ngữ ký hiệu SASL', 
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}