import 'package:all_meal_app/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/providers/meals_provider.dart';
import 'package:all_meal_app/screens/meal_screen.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  List<CategoryMealModel> mealsList = [];
  bool isLoading = true;

  final _shimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
  @override
  void initState() {
    super.initState();
    getAllMeals();
  }

  void getAllMeals() async {
    bool isMealListPresent =
        Provider.of<MealsProvider>(context, listen: false).isMealsListPresent();

    if (!isMealListPresent) {
      await Provider.of<MealsProvider>(context, listen: false).getAllMeals();
      setState(() {
        mealsList =
            Provider.of<MealsProvider>(context, listen: false).getMeals();
        isLoading = false;
      });
    } else {
      setState(() {
        mealsList = Provider.of<MealsProvider>(context, listen: false).meals;
        isLoading = false;
      });
    }
  }

  void _onSelectMeal(CategoryMealModel categoryMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealScreen(
          categoryMeal: categoryMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String searchText = context.watch<SearchProvider>().searchText;
    List<CategoryMealModel> meals = mealsList;
    RegExp pattern = RegExp(searchText, caseSensitive: false);

    if (searchText.trim().isNotEmpty) {
      meals = meals.where((meal) => pattern.hasMatch(meal.title)).toList();
    }
    Widget content = Container(
      decoration: ConstantColors.gradientContainer,
      child: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final categoryMeal = meals[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  _onSelectMeal(categoryMeal);
                },
                leading: Hero(
                  tag: categoryMeal.id,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Image.network(
                      categoryMeal.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(categoryMeal.title),
              ),
            ),
          );
        },
      ),
    );

    if (isLoading) {
      content = Container(
        decoration: ConstantColors.gradientContainer,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
      content = ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return _shimmerGradient.createShader(bounds);
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      );
    }
    
    return content;
  }
}
