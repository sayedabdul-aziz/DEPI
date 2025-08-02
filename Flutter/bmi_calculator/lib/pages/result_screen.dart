import 'package:bmi_calculator/utils/colors.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});
  final double result;

  String getCategory() {
    if (result < 18.5) {
      return 'Underweight';
    } else if (result < 25) {
      return 'Normal';
    } else if (result < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/050/817/819/small_2x/happy-smiling-male-doctor-with-hand-present-something-empty-space-standing-isolate-on-transparent-background-png.png',
                width: 200,
                height: 200,
              ),
            ),
            Divider(indent: 20, endIndent: 20),
            Text(
              getCategory(),
              style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
            ),
            SizedBox(height: 20),
            Text(result.toStringAsFixed(2), style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
