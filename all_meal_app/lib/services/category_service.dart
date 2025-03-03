import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:all_meal_app/models/category_model.dart';

class CategoryService {
  static Future<List<CategoryModel>> getAllCategories() async {
    final List<CategoryModel> categoriesList = [];
    final url =
        Uri.https('www.themealdb.com', '/api/json/v1/1/categories.php');

    final response = await http.get(url);

    final data = json.decode(response.body);

    final categories = data['categories'];

    for (final category in categories) {
      CategoryModel model = CategoryModel(
        id: category['idCategory'],
        title: category['strCategory'],
        imageUrl: category['strCategoryThumb'],
        description: category['strCategoryDescription'],
      );
      categoriesList.add(model);
    }

    return categoriesList;
  }
}
