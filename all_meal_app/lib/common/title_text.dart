import 'package:all_meal_app/common/appbar_background.dart';
import 'package:flutter/material.dart';

class CustomText {
  final String title;

  CustomText({
    required this.title,
  });

  Widget toTitleText() {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: ConstantColors.TitleTextColor,
      ),
    );
  }
}
