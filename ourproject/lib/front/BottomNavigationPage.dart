import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'MyDetailPage.dart';
import 'MyContactPage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key, required this.title});
  final String title;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndexSelected = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndexSelected = index;
    });
  }

  final List<Widget> _tabs = [
    MyHomePage(),
    MyDetailPage(),
    MyContactPage(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              color: Colors.purpleAccent,
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0), 
              child: const Text(
                "Ứng dụng hỗ trợ học ngôn ngữ kí hiệu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 25, 
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Phần nội dung thay đổi theo tab được chọn
          Expanded(
            child: _tabs[_currentIndexSelected],
          ),
        ],
      ),
      
      
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Detail", icon: Icon(Icons.details)),
          BottomNavigationBarItem(label: "Contact", icon: Icon(Icons.contact_emergency)),
        ],
        currentIndex: _currentIndexSelected,
        onTap: _onItemTapped,
      ),
    );
  }
}