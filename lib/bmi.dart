import 'package:flutter/material.dart';
import 'dart:math';

class BMIScreen extends StatelessWidget {
  final int weight;
  final int height;

  const BMIScreen({super.key, required this.weight, required this.height});

  double _calculateBMI() {
    if (height <= 0) return 0; // Prevent division by zero
    double heightInMeters = height / 100; // Convert cm to meters
    return weight / (heightInMeters * heightInMeters);
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi >= 18.5 && bmi < 24.9) return "Normal";
    if (bmi >= 25 && bmi < 29.9) return "Overweight";
    if (bmi >= 30 && bmi < 34.9) return "Obese";
    return "Severely Obese";
  }

  double _getIndicatorAngle(double bmi) {
    double minBMI = 15.0;
    double maxBMI = 40.0;
    double minAngle = -pi / 3;
    double maxAngle = pi / 3;

    bmi = bmi.clamp(minBMI, maxBMI);
    return minAngle + ((bmi - minBMI) / (maxBMI - minBMI)) * (maxAngle - minAngle);
  }

  @override
  Widget build(BuildContext context) {
    double bmi = _calculateBMI();
    String bmiCategory = _getBMICategory(bmi);
    double needleAngle = _getIndicatorAngle(bmi);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              Image.asset("assets/logo.png", height: 50),
              SizedBox(height: 20),

              Text(
                "You are $bmiCategory",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/bmipict.png", width: 800),

                  Transform.translate(
                    offset: Offset(0, 98),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Transform.translate(
                    offset: Offset(0, 50),
                    child: Transform.rotate(
                      angle: needleAngle,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 90,
                        width: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.black,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        fixedSize: Size(110, 40),
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: Color(0xFF47DF7C)),
                          SizedBox(width: 5),
                          Text("Previous",
                              style: TextStyle(
                                color: Color(0xFF47DF7C),
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        minimumSize: Size(100, 40),
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text("Next",
                              style: TextStyle(
                                color: Color(0xFF47DF7C),
                                fontSize: 16,
                              )),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, color: Color(0xFF47DF7C)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
