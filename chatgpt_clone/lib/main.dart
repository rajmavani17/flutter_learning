import 'package:chatgpt_clone/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal AI Bot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Noto',
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
