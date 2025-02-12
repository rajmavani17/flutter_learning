import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/pages/homepage_material.dart';
import 'package:currency_converter/pages/homepage_cupertino.dart';

void main() {
  runApp(MyMaterialApp());
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MaterialHomePage(),
    );
  }
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  CupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: CupertinoHomePage(),
    );
  }
}