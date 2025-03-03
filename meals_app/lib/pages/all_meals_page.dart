import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/pages/meals_details_page.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/widgets/meal_item.dart';

class AllMealsPage extends ConsumerStatefulWidget {
  const AllMealsPage({
    super.key,
    required this.showAppbar,
  });

  final bool showAppbar;
  @override
  ConsumerState<AllMealsPage> createState() => _AllMealsPageState();
}

class _AllMealsPageState extends ConsumerState<AllMealsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    void onSelectMeal(BuildContext context, MealModel meal) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MealsDetailsPage(
            meal: meal,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: widget.showAppbar
          ? AppBar(
              title: Text('All Meals'),
            )
          : null,
      body: SizedBox(
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealItem(
              meal: meal,
              onSelectMeal: (meal) {
                onSelectMeal(context, meal);
              },
            );
          },
        ),
      ),
    );
  }
}
