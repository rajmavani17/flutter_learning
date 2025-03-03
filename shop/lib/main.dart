import 'package:flutter/material.dart';
import 'package:shop/pages/shop_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 78, 53, 3),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 58, 3, 168),
        ),
        
        scaffoldBackgroundColor: const Color.fromARGB(172, 75, 64, 64),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: ShopListPage(),
    );
  }
}
