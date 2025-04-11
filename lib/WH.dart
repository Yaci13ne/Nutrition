import 'package:flutter/material.dart';
import 'bmi.dart';

void main() {
  runApp(GymFitXApp());
}

class GymFitXApp extends StatelessWidget {
  const GymFitXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeightHeightScreen(),
    );
  }
}

class WeightHeightScreen extends StatefulWidget {
  const WeightHeightScreen({super.key});

  @override
  _WeightHeightScreenState createState() => _WeightHeightScreenState();
}

class _WeightHeightScreenState extends State<WeightHeightScreen> {
  int _selectedWeight = 65;
  double _height = 170;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/weightheightpage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 150,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "What is Your weight ?",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'bolditalic',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: ListWheelScrollView.useDelegate(
                        controller: FixedExtentScrollController(
                            initialItem: _selectedWeight - 45),
                        itemExtent: 45,
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedWeight = index + 45;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            int weight = 45 + index;
                            bool isSelected = weight == _selectedWeight;
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: isSelected ? 120 : 90,
                              height: isSelected ? 60 : 40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green.shade600
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "$weight Kg",
                                style: TextStyle(
                                  fontSize: isSelected ? 26 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                          childCount: 51,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "What is Your Height ?",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'bolditalic',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(11, (index) {
                            int value = 250 - ((250 - 50) ~/ 10 * index);
                            return SizedBox(
                              height: 22.7,
                              child: Text(
                                "$value",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          height: 280,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: _height,
                              min: 50,
                              max: 250,
                              activeColor: Colors.blue,
                              inactiveColor: Colors.grey.shade300,
                              thumbColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {
                                  _height = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${_height.round()} cm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text("Previous",
                          style: TextStyle(color: Color(0xFF47DF7C))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BMIScreen(
                                    weight: _selectedWeight,
                                    height: _height.round(),
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text("Next",
                          style: TextStyle(color: Color(0xFF47DF7C))),
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
