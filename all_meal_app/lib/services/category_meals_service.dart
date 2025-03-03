import 'dart:convert';
import 'package:all_meal_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:all_meal_app/models/category_meal_model.dart';

class CategoryMealsService {
  static Future<List<CategoryMealModel>> getCategotyModels(
      CategoryModel category) async {
    final List<CategoryMealModel> categoryMealList = [];
    final url = Uri.https('www.themealdb.com', '/api/json/v1/1/filter.php', {
      'c': category.title,
    });

  final response = await http.get(url);

    final data = json.decode(response.body);

    final categories = data['meals'];

    for (final category in categories) {
      CategoryMealModel model = CategoryMealModel(
        id: category['idMeal'],
        title: category['strMeal'],
        imageUrl: category['strMealThumb'],
      );
      categoryMealList.add(model);
    }

    return categoryMealList;
  }
}
