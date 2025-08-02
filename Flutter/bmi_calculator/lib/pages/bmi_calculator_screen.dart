import 'package:bmi_calculator/pages/result_screen.dart';
import 'package:bmi_calculator/utils/colors.dart';
import 'package:flutter/material.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  int weight = 60;
  int age = 20;
  int height = 160;
  bool isMale = true;

  //Color x = (condition) ? Color : Color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            maleAndFemale(),
            SizedBox(height: 15),
            heightUi(),
            SizedBox(height: 15),
            weightAndAge(),
            SizedBox(height: 15),
            calculateBtn(),
          ],
        ),
      ),
    );
  }

  SizedBox calculateBtn() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          // BMI = weight (kg) / height (m²).
          double result = weight / (height * height * 0.0001);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(result: result),
            ),
          );
        },
        child: Text(
          'Calculate',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  Expanded heightUi() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Height', style: TextStyle(color: AppColors.whiteColor)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  height.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                Text('cm', style: TextStyle(color: AppColors.whiteColor)),
              ],
            ),
            Slider(
              value: height.toDouble(),
              onChanged: (value) {
                setState(() {
                  height = value.toInt();
                });
              },
              min: 70,
              max: 220,
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }

  Expanded maleAndFemale() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMale = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isMale ? AppColors.primaryColor : AppColors.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.male, size: 100, color: AppColors.whiteColor),
                      Text(
                        'MALE',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMale = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isMale ? AppColors.cardColor : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.female,
                        size: 100,
                        color: AppColors.whiteColor,
                      ),
                      Text(
                        'FEMALE',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded weightAndAge() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weight',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      weight.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              weight--;
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              weight++;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Age', style: TextStyle(color: AppColors.whiteColor)),
                    SizedBox(height: 10),
                    Text(
                      age.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              age--;
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              age++;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
