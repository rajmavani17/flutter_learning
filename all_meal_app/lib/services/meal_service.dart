import 'dart:convert';

import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/models/category_model.dart';
import 'package:all_meal_app/models/meal_model.dart';
import 'package:all_meal_app/services/category_service.dart';
import 'package:http/http.dart' as http;

class MealService {
  static Future<MealModel> getSingleMealById(String id) async {
    final url = Uri.https('www.themealdb.com', '/api/json/v1/1/lookup.php', {
      'i': id,
    });

    final response = await http.get(url);

    final data = json.decode(response.body);

    final mealData = data['meals'][0];

    return MealModel(
      id: mealData['idMeal'] ?? '',
      title: mealData['strMeal'] ?? '',
      drinkAlternate: mealData['strDrinkAlternate'] ?? '',
      category: mealData['strCategory'] ?? '',
      area: mealData['strArea'] ?? '',
      instructions: formatInstructions(mealData),
      imageUrl: mealData['strMealThumb'] ?? '',
      videoUrl: mealData['strYoutube'] ?? '',
      tags: mealData['strTags'] ?? '',
      ingredients: getIngredientsFromData(mealData),
    );
  }

  static Future<List<CategoryMealModel>> getAllMeals() async {
    List<CategoryModel> categories = await CategoryService.getAllCategories();

    List<CategoryMealModel> allMeals = [];

    for (final category in categories) {
      final mealByCategory = await getAllMealsByCategory(category.title);
      allMeals = [...allMeals, ...mealByCategory];
    }
    return allMeals;
  }

  static Future<List<CategoryMealModel>> getAllMealsByCategory(
      String category) async {
    List<CategoryMealModel> mealsList = [];
    final url = Uri.https('www.themealdb.com', '/api/json/v1/1/filter.php', {
      'c': category,
    });
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    final meals = data['meals'];

    for (final meal in meals) {
      CategoryMealModel model = CategoryMealModel(
        id: meal['idMeal'],
        title: meal['strMeal'],
        imageUrl: meal['strMealThumb'],
      );
      mealsList.add(model);
    }

    return mealsList;
  }

  static List<Map<String, String>> getIngredientsFromData(
      Map<dynamic, dynamic> data) {
    List<Map<String, String>> res = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = data['strIngredient$i'];
      String? measure = data['strMeasure$i'];

      if (ingredient != null &&
          ingredient.isNotEmpty &&
          measure != null &&
          measure.isNotEmpty) {
        res.add({
          'ingredient': ingredient,
          'measure': measure,
        });
      }
    }
    return res;
  }

  static List<String> getInstructionsFromData(Map<dynamic, dynamic> data) {
    String strInstructions = data['strInstructions'];
    RegExp regExp = RegExp(r'(?<=[.!?])\s+');
    List<String> sentences = strInstructions.split(regExp);
    return sentences;
    // return instructions;
  }

  static List<String> formatInstructions(Map<dynamic, dynamic> data) {
    String instructions = data['strInstructions'];
    if (instructions.isEmpty) return ["No instructions available."];

    return instructions
        .replaceAll('\r', '') // Remove carriage returns
        .split(
            RegExp(r'(?<!\b(?:e\.g|i\.e))\. |\n')) // Split on ". " or new lines
        .map((step) => step.trim()) // Trim extra spaces
        .where((step) => step.isNotEmpty) // Remove empty steps
        .map((step) =>
            "${step[0].toUpperCase()}${step.substring(1)}") // Capitalize first letter
        .toList();
  }
}
