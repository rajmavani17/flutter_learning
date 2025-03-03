import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/category_model.dart';
import 'package:all_meal_app/providers/category_provider.dart';
import 'package:all_meal_app/screens/category_screen.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<CategoryModel> categoryList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategotyModels();
  }

  void getCategotyModels() async {
    bool isCategoryListPresent =
        Provider.of<CategoryProvider>(context, listen: false)
            .isCategoryListPresent();

    if (!isCategoryListPresent) {
      await Provider.of<CategoryProvider>(context, listen: false)
          .getAllCategory();
      setState(() {
        categoryList = Provider.of<CategoryProvider>(context, listen: false)
            .getCategories();
        isLoading = false;
      });
    } else {
      setState(() {
        categoryList = Provider.of<CategoryProvider>(context, listen: false)
            .getCategories();
        isLoading = false;
      });
    }
  }

  void _onSelectCategory(CategoryModel category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CategoryScreen(category: category);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantColors.gradientContainer,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final category = categoryList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: SizedBox(
                    height: 75,
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          _onSelectCategory(category);
                        },
                        leading: Hero(
                          tag: category.id,
                          child: Image.network(
                            category.imageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        title: Text(
                          category.title,
                          style: TextStyle(
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
