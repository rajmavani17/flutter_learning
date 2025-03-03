import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/providers/favourite_meals_provider.dart';
import 'package:all_meal_app/screens/meal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteMealsListScreen extends StatefulWidget {
  const FavouriteMealsListScreen({super.key});

  @override
  State<FavouriteMealsListScreen> createState() =>
      _FavouriteMealsListScreenState();
}

class _FavouriteMealsListScreenState extends State<FavouriteMealsListScreen> {
  List<CategoryMealModel> favouriteMeals = [];

  @override
  void initState() {
    super.initState();
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
    favouriteMeals = Provider.of<FavouriteMealsProvider>(context).favouriteMeals;
       Widget content = Container(
      decoration: ConstantColors.gradientContainer,
      child: ListView.builder(
        itemCount: favouriteMeals.length,
        itemBuilder: (context, index) {
          final categoryMeal = favouriteMeals[index];
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
    return Scaffold(
      // appBar: AppBar(
      //   title: CustomText(title: 'Favourite Meals').toTitleText(),
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: <Color>[
      //           ConstantColors.ScaffoldBgColor,
      //           Colors.white,
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: content,
    );
  }
}
