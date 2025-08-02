import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.menu, color: Colors.deepOrange),
        title: Text(
          "My First Screen",
          style: TextStyle(color: Colors.deepOrange),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.deepOrange),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              "Ahmed Ali",
              style: TextStyle(
                fontSize: 22,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook_rounded, color: Colors.blue),
                SizedBox(width: 15),
                Icon(Icons.snapchat_sharp, color: Colors.yellow),
                SizedBox(width: 15),
                Icon(Icons.telegram_rounded, color: Colors.blue),
                SizedBox(width: 15),
                Icon(Icons.camera_alt_rounded, color: Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
