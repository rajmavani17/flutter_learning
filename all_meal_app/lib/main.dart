import 'package:all_meal_app/providers/category_provider.dart';
import 'package:all_meal_app/providers/favourite_meals_provider.dart';
import 'package:all_meal_app/providers/filter_provider.dart';
import 'package:all_meal_app/providers/meals_provider.dart';
import 'package:all_meal_app/providers/search_provider.dart';
import 'package:all_meal_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouriteMealsProvider()),
        ChangeNotifierProvider(create: (_) => MealsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          appBarTheme: AppBarTheme(
            color: const Color.fromARGB(255, 70, 131, 181),
          ),
          cardTheme: CardTheme(),
          scaffoldBackgroundColor: Colors.blue,
          textTheme: TextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
