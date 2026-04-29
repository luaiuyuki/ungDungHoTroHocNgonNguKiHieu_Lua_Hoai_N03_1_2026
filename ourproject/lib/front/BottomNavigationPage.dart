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
              padding: const EdgeInsets.symmetric(vertical: 12.0), 
              child: const Text(
                "Ứng dụng hỗ trợ học ngôn ngữ kí hiệu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25, 
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://static.wixstatic.com/media/41a9b2_372cd6c5757f47479be1577541a08d7b~mv2.png/v1/fill/w_980,h_551,al_c,q_90,usm_0.66_1.00_0.01,enc_avif,quality_auto/41a9b2_372cd6c5757f47479be1577541a08d7b~mv2.png',
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 80);
              },
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