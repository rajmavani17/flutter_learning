import 'package:flutter/material.dart';

class ConstantColors {
  // static Color ScaffoldBgColor = const Color.fromARGB(255, 218, 218, 219);
  static Color ScaffoldBgColor = const Color.fromARGB(255, 180, 221, 255);
  static Color TitleTextColor = const Color.fromARGB(255, 66, 66, 219);

  static BoxDecoration gradientContainer = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Colors.white,
        ScaffoldBgColor,
        // Colors.white,
        // ScaffoldBgColor,
        // Colors.white,
      ],
    ),
  );
}
