import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BasketManager extends ChangeNotifier {
  static final BasketManager _instance = BasketManager._internal();
  factory BasketManager() => _instance;
  BasketManager._internal() {
    _loadConfirmedItems(); // Load saved items when app starts
  }

  final List<Map<String, dynamic>> _foodItems = [
    
  ];

  final List<Map<String, dynamic>> _confirmedItems = [];

  List<Map<String, dynamic>> get foodItems => List.unmodifiable(_foodItems);
  List<Map<String, dynamic>> get confirmedItems => List.unmodifiable(_confirmedItems);

  void addItem(Map<String, dynamic> item) {
    if (!_foodItems.any((element) => element['name'] == item['name'])) {
      _foodItems.add(item);
      notifyListeners();
    }
  }

  bool isItemAdded(String name) => _foodItems.any((item) => item['name'] == name);

  void removeItem(String name) {
    _foodItems.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }
void confirmItem(String name) {
  final item = _foodItems.firstWhere(
    (item) => item['name'] == name,
    orElse: () => {},
  );

  if (item.isNotEmpty) {
    removeExpiredItems(); // Ensure old items are cleared

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    print("Confirming Item: ${item['name']}, Timestamp: $timestamp");

    _confirmedItems.add({
      'name': item['name'],
      'image': item['image'],
      'calories': item['calories'],
      'fats': item['fats'],
      'protein': item['protein'],
      'carbs': item['carbs'],
      'timestamp': timestamp,
    });

    _foodItems.removeWhere((item) => item['name'] == name);
    _saveConfirmedItems();
    notifyListeners();
  }
}
void removeExpiredItems() {
  final now = DateTime.now();
  
  print("Current Time: $now");
  print("Before Cleanup: $_confirmedItems");

  _confirmedItems.removeWhere((item) {
    final itemTime = item['timestamp'] as int? ?? 0;
    final itemDateTime = DateTime.fromMillisecondsSinceEpoch(itemTime);
    final difference = now.difference(itemDateTime);
    final expired = difference.inHours >= 24; // Check if 24 hours have passed
    
    if (expired) {
      print("Removing Item: ${item['name']}, Added: $itemDateTime, Now: $now");
    }
    return expired;
  });

  print("After Cleanup: $_confirmedItems");

  _saveConfirmedItems();
  notifyListeners();
}

  // --- Persistence Methods ---
  Future<void> _saveConfirmedItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('confirmedItems', jsonEncode(_confirmedItems));
  }
Future<void> _loadConfirmedItems() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString('confirmedItems');
  if (data != null) {
    _confirmedItems.clear();
    List<dynamic> decodedData = jsonDecode(data);

    // Ensure timestamps are properly restored as integers
    _confirmedItems.addAll(decodedData.map((item) {
      return {
        'name': item['name'],
        'image': item['image'],
        'calories': item['calories'],
        'fats': item['fats'],
        'protein': item['protein'],
        'carbs': item['carbs'],
        'timestamp': (item['timestamp'] as num).toInt(), // Ensures correct type
      };
    }));

    removeExpiredItems(); // Cleanup old items
    notifyListeners();
  }
}

  int get totalCalories => _confirmedItems.fold(0, (sum, item) => sum + (item['calories'] as num).toInt());
  int get totalProtein => _confirmedItems.fold(0, (sum, item) => sum + (item['protein'] as num).toInt());
  int get totalCarbs => _confirmedItems.fold(0, (sum, item) => sum + (item['carbs'] as num).toInt());
  int get totalFats => _confirmedItems.fold(0, (sum, item) => sum + (item['fats'] as num).toInt());
}
