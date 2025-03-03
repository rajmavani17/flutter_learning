import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/pages/meals_page.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({
    super.key,
    required this.availableMeals,
  });

  final List<MealModel> availableMeals;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryModel category) {
    final List<MealModel> categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsPage(
          title: category.title,
          meals: categoryMeals,
        ),
      ),
    );
  }

  @override
  Widget build2(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: [
        ...dummyData.map(
          (data) => CategoryGridItem(
            category: data,
            onSelectCategory: () {
              _selectCategory(context, data);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          ...dummyData.map(
            (data) => CategoryGridItem(
              category: data,
              onSelectCategory: () {
                _selectCategory(context, data);
              },
            ),
          ),
        ],
      ),
      builder: (context, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0.0, 1),
            end: Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
