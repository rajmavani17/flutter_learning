import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tossResult = 'Heads';

  void initState() {
    super.initState();
    tossResult = tossCoin();
  }

  String tossCoin() {
    var random = Random();
    return random.nextInt(2) % 2 == 0 ? 'Heads' : 'Tails';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Toss'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(tossResult),
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      tossResult = tossCoin();
                    },
                  );
                  print(tossResult);
                },
                child: const Text('Toss'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
