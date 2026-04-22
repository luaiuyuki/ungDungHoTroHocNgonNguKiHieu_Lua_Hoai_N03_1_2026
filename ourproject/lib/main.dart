import 'package:flutter/material.dart';


// CÂU 2.1: XÂY DỰNG GENERICS CLASS TỔNG QUÁT 

class DataBox<T> {
  T obj;
  DataBox(this.obj);


  void printData() {
    print("📦 [Generics Output]: $obj");
  }
}

void main() {
  // --- THỰC THI CÂU 2 NGAY KHI CHẠY APP ---
  print("======= BÀI TẬP Đặng Thị Thu Hoài - 23010316 =======");
  
  // 1. Tạo danh sách sinh viên theo mẫu của cô
  var studentList = [
    {'studentID': '2301****', 'fullname': 'Nguyễn Thị Lụa'},
    {'studentID': '23010316', 'fullname': 'Đặng Thị Thu Hoài'},
  ];

  // 2. Sử dụng Generics Class để in dữ liệu
  var box = DataBox(studentList);
  box.printData(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng hỗ trợ ngôn ngữ kí hiệu SASL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Học Ngôn Ngữ Kí Hiệu SASL'),
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
  String name = "Đặng Thị Thu HOÀI";
  String mssv = "23010316";
  String lop = "N03";
  int totalSigns = 15;        
  double accuracy = 0.92;     
  String label = "Cảm ơn";    
  double confidence = 0.95;   

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ==========================================================
    // CÂU 2.2: SỬ DỤNG COLLECTIONS CHO GIAO DIỆN
    // ==========================================================
    Map<String, dynamic> userProfile = {
      'ten': name,
      'id': mssv,
      'lopHoc': lop,
    };

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
            children: <Widget>[
              // --- HIỂN THỊ THÔNG TIN (ROW) ---
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
                      Text("ID: ${userProfile['id']}", 
                        style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              
              // Widget hiển thị thông số bài học
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Tiến độ: $totalSigns ký hiệu', style: const TextStyle(fontSize: 16)),
                    Text('Độ chính xác: ${(accuracy * 100).toStringAsFixed(1)}%', 
                      style: const TextStyle(fontSize: 16, color: Colors.blue)),
                    const Divider(),
                    Text('Tương tác: $_counter lần', style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("LỊCH SỬ THỰC HÀNH", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple)),
              ),
              
              const SizedBox(height: 10),

              // --- HIỂN THỊ DANH SÁCH (COLUMN) ---
              Column(
                children: signHistory.map((item) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.front_hand, size: 20)),
                      title: Text("Ký hiệu: ${item['sign']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Tin cậy: ${(item['score'] * 100).toStringAsFixed(0)}%"),
                      trailing: Text(item['status'], 
                        style: TextStyle(color: item['status'] == 'Đạt' ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 20),
              const Text('MSSV: 0003068 - Dự án SASL'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}