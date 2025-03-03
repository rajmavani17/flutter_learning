import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';

class FavouriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavouriteMealsNotifier() : super([]);
  bool toggleFavouriteMealStatus(MealModel meal) {
    if (state.contains(meal)) {
      state = state
          .where(
            (m) => m.id != meal.id,
          )
          .toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<MealModel>>(
  (ref) {
    return FavouriteMealsNotifier();
  },
);
