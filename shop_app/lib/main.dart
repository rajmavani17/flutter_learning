import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Your Cart',
        theme: ThemeData(
          fontFamily: 'Lato',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            primary: Colors.amber,
          ),
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(239, 238, 249, 1),
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            centerTitle: true,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              fontFamily: 'Lato',
            ),
            prefixIconColor: Colors.blueGrey,
          ),
          textTheme: TextTheme(
              titleLarge: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              bodySmall: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
