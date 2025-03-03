import 'package:flutter/material.dart';
import 'package:shop/models/category_model.dart';

final categories = {
  Categories.vegetables: CategoryModel(
    title: 'Vegetables',
    color: Color.fromARGB(255, 0, 255, 128),
    image: Image.asset('assets/images/vegetable.png'),
  ),
  Categories.fruit: CategoryModel(
    title: 'Fruit',
    color: Color.fromARGB(255, 145, 255, 0),
    image: Image.asset('assets/images/fruits.png'),
  ),
  Categories.meat: CategoryModel(
    title: 'Meat',
    color: Color.fromARGB(255, 255, 102, 0),
    image: Image.asset('assets/images/meat.png'),
  ),
  Categories.dairy: CategoryModel(
    title: 'Dairy',
    color: Color.fromARGB(255, 0, 208, 255),
    image: Image.asset('assets/images/dairy-products.png'),
  ),
  Categories.carbs: CategoryModel(
    title: 'Carbs',
    color: Color.fromARGB(255, 0, 60, 255),
    image: Image.asset('assets/images/bread.png'),
  ),
  Categories.sweets: CategoryModel(
    title: 'Sweets',
    color: Color.fromARGB(255, 255, 149, 0),
    image: Image.asset('assets/images/sweets.png'),
  ),
  Categories.spices: CategoryModel(
    title: 'Spices',
    color: Color.fromARGB(255, 255, 187, 0),
    image: Image.asset('assets/images/spices.png'),
  ),
  Categories.convenience: CategoryModel(
    title: 'Convenience',
    color: Color.fromARGB(255, 191, 0, 255),
    image: Image.asset('assets/images/room-service.png'),
  ),
  Categories.hygiene: CategoryModel(
    title: 'Hygiene',
    color: Color.fromARGB(255, 149, 0, 255),
    image: Image.asset('assets/images/washing-hands.png'),
  ),
  Categories.other: CategoryModel(
    title: 'Other',
    color: Color.fromARGB(255, 0, 225, 255),
    image: Image.asset('assets/images/more.png'),
  ),
};
