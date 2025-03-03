import 'package:all_meal_app/models/category_model.dart';
import 'package:all_meal_app/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> categories = [];

  Future<void> getAllCategory() async {
    categories = await CategoryService.getAllCategories();
    notifyListeners();
  }

  List<CategoryModel> getCategories() {
    return categories;
  }

  bool isCategoryListPresent() {
    return categories.isNotEmpty;
  }
}
