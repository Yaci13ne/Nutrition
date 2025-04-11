import 'package:flutter/material.dart';
import 'dart:io';

class MealDetailScreen extends StatelessWidget {
  final Map<String, dynamic> meal;

  const MealDetailScreen({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal['mealName'])),
      body: Center(child: Text('Calories: ${meal['totalCalories']} kcal')),
    );
  }
}
