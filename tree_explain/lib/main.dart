import 'package:flutter/material.dart';
import 'package:tree_explain/keys/keys.dart';

// import 'package:tree_explain/ui_updates_demo.dart';
enum Priority { urgent, normal, low }

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const Keys(),
      ),
    );
  }
}
