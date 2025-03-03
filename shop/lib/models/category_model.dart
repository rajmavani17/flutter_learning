import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class CategoryModel {
  final String title;
  final Color color;
  final Image image;

  const CategoryModel({
    required this.color,
    required this.title,
    required this.image,
  });
}
