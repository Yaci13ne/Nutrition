import 'package:flutter/material.dart';

void main() {
  runApp(GymFitXApp());
}

class GymFitXApp extends StatelessWidget {
  const GymFitXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(userName: "Fares"), // Example name
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final String userName;

  const WelcomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pictures/1-9.png"), // Background Image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // **Welcome Text at the Top**
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Text(
                "Welcome, $userName !",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'bolditalic',
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // **GymFitX Logo**
            Image.asset(
              "pictures/GymFitXnutrition-removebg-preview.png",
              height: 330,
              fit: BoxFit.contain,
            ),

            // **Tagline (Under the Logo)**
            /*
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                "every meal counts, choose wisely",
                style: TextStyle(fontSize: 16, fontFamily: 'lexenddeca'),
              ),
            ),
*/
            // SizedBox(height: 0),

            // **Get Started Button**
            ElevatedButton(
              onPressed: () {
                print("Get Started Clicked!");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Color.fromARGB(255, 71, 223, 124),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Get Started !",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'bolditalic',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    'pictures/next.png',
                    fit: BoxFit.fill,
                    width: 20,
                    height: 20,
                  )
                  // Icon(Icons.arrow_forward, color: Colors.black),
                ],
              ),
            ),

            Spacer(), // Pushes content up
          ],
        ),
      ),
    );
  }
}