import 'package:flutter/material.dart';


class MyContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listUser = {'name': 'Nguyễn Thị Lụa', 'createdAt': '15/04/2026'};

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                    SizedBox(height: 15),
                    

                    Text(
                      "Họ tên: ${listUser['name']}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    
                    SizedBox(height: 10),
                    
                    

                    Text(
                      "Ngày tham gia: ${listUser['createdAt']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}