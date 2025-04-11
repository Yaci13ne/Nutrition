import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'basket_manager.dart';
import 'fabtab.dart';
import 'theme_notifier.dart';  // Import the ThemeNotifier

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BasketManager()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),  // Add ThemeNotifier provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current theme state
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,  // Switch theme based on the notifier state
      home: FabTabs(),
    );
  }
}
