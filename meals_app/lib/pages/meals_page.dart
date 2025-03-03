import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/pages/meals_details_page.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<MealModel> meals;

  void onSelectMeal(BuildContext context, MealModel meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsDetailsPage(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh...........\nnothing to display here',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Select a category which has meals!!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: MealItem(
              meal: meal,
              onSelectMeal: (meal) {
                onSelectMeal(context, meal);
              },
            ),
          );
        },
      );
    }

    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
          ),
        ),
        body: content,
      );
    }
  }
}
