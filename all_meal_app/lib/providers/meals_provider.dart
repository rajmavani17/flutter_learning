import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/services/meal_service.dart';
import 'package:flutter/material.dart';

class MealsProvider extends ChangeNotifier {
  List<CategoryMealModel> meals = [];

  Future<void> getAllMeals() async {
    meals = await MealService.getAllMeals();
    notifyListeners();
  }

  List<CategoryMealModel> getMeals() {
    return meals;
  }
  
  bool isMealsListPresent () {
    return meals.isNotEmpty;
  }
}
