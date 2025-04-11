import 'package:flutter/material.dart';
import 'bmi.dart';

class UserData {
  static double weight = 70.0; // Default value
  static double height = 1.75; // Default value (in meters)
}

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Your Data")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weight (kg):"),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            Text("Height (m):"),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  UserData.weight = double.tryParse(weightController.text) ?? 70.0;
                  UserData.height = double.tryParse(heightController.text) ?? 1.75;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BMIScreen()),
                );
              },
              child: Text("Calculate BMI"),
            ),
          ],
        ),
      ),
    );
  }
}
