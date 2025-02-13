import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index1 = 1;
  int index2 = 1;
  List<String> fileNames = [
    'assets/images/dice-1.png',
    'assets/images/dice-2.png',
    'assets/images/dice-3.png',
    'assets/images/dice-4.png',
    'assets/images/dice-5.png',
    'assets/images/dice-6.png',
  ];

  @override
  void initState() {
    super.initState();
    index1 = Random().nextInt(6);
    index2 = Random().nextInt(6);
  }

  void rollDice() {
    setState(() {
      index1 = Random().nextInt(6);
      index2 = Random().nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Roll Dice"),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: rollDice,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(fileNames[index1]),
                        fit: BoxFit.contain,
                        width: 300,
                      ),
                      Image(
                        image: AssetImage(fileNames[index2]),
                        fit: BoxFit.contain,
                        width: 300,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: rollDice,
                  child: Text("Roll"),
                ),
              ],
            ),
          ),
        ));
  }
}
