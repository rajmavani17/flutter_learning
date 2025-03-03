import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:flutter/material.dart';

class FavouriteMealsProvider extends ChangeNotifier {
  List<CategoryMealModel> favouriteMeals = [];

  void addToFavourites(CategoryMealModel meal) {
    if (favouriteMeals.contains(meal)) {
      favouriteMeals.remove(meal);
    } else {
      favouriteMeals.add(meal);
    }
    notifyListeners();
  }

  bool isFavourite(CategoryMealModel model){
    return favouriteMeals.contains(model);
  }
}
