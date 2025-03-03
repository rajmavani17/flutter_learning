import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/provider/favourite_meals_provider.dart';

class MealsDetailsPage extends ConsumerWidget {
  const MealsDetailsPage({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);
    final icon = isFavourite ? Icons.favorite : Icons.favorite_border;

    final bgColor = favouriteMeals.contains(meal)
        ? const Color.fromARGB(255, 255, 171, 171)
        : const Color.fromARGB(255, 163, 255, 210);

    void addToFavourites() {
      final bool isAdded = ref
          .read(favouriteMealsProvider.notifier)
          .toggleFavouriteMealStatus(meal);

      final message = isAdded
          ? '${meal.title} is added to favourites'
          : '${meal.title} is removed from favourite';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: bgColor,
        ),
      );
    }

    Widget getTitleText(String title) {
      return Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
      );
    }

    Widget getSubtitleText({String? subtitle, TextAlign? align, Color? color}) {
      return Text(
        subtitle ?? '',
        textAlign: align,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
      );
    }

    Widget getVegOrNonVeg() {
      if (meal.isVegetarian) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.green,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Text(
                  'Veg',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      if (!meal.isVegetarian) {
        return Container(
          width: 40,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.red,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Text(
                  'Non\nVeg',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Container();
    }

    Widget getPriceWidget() {
      if (meal.affordability == Affordability.affordable) {
        return Text(
          '\$',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      }
      if (meal.affordability == Affordability.luxurious) {
        return Text(
          '\$\$',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      }
      if (meal.affordability == Affordability.pricey) {
        return Text(
          '\$\$\$',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      }

      return Container();
    }

    Widget getFeatures() {
      int duration = meal.duration;

      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timelapse),
                getSubtitleText(
                  subtitle: ' $duration min',
                ),
                SizedBox(
                  width: 10,
                ),
                getVegOrNonVeg(),
                SizedBox(
                  width: 10,
                ),
                getPriceWidget(),
              ],
            ),
          ],
        ),
      );
    }

    List<Widget> getCookingSteps() {
      List<Widget> steps = [];

      for (int index = 0; index < meal.steps.length; index++) {
        String step = meal.steps[index];
        steps.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        color: index.isEven
                            ? const Color.fromARGB(255, 36, 46, 51)
                            : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8)),
                    child: getSubtitleText(
                      subtitle: '${index + 1}',
                      align: TextAlign.center,
                      color: index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: getSubtitleText(subtitle: step, align: TextAlign.left),
                ),
              ],
            ),
          ),
        );
      }
      return [Column(children: steps)];
    }

    Widget getImage() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
        ),
        child: Image.network(
          meal.imageUrl,
          height: 250,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    List<Widget> getIngredients() {
      List<Widget> ingredients = [];

      for (final ingredient in meal.ingredients) {
        ingredients.add(
          Text(
            ingredient,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
          ),
        );
      }
      return ingredients;
    }

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final double maxExtent = 200.0;
                  final double minExtent = kToolbarHeight;
                  final double percent = ((constraints.maxHeight - minExtent) /
                          (maxExtent - minExtent))
                      .clamp(0.0, 1.0);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        meal.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black
                            .withAlpha(((1 - percent) * 255).toInt()),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Opacity(
                            opacity: percent,
                            child: Text(
                              meal.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: addToFavourites,
                  tooltip: 'Favourite',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Icon(
                      icon,
                      key: ValueKey(isFavourite),
                      color: Colors.white,
                    ),
                    transitionBuilder: (widget, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: widget,
                      );
                    },
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 15),
                getFeatures(),
                const SizedBox(height: 15),
                getTitleText('Ingredients'),
                const SizedBox(height: 15),
                ...getIngredients(),
                const SizedBox(height: 24),
                getTitleText('Steps'),
                const SizedBox(height: 15),
                ...getCookingSteps(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

/* 
body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            
            actions: [
              getImage(),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  
                  SizedBox(
                    height: 15,
                  ),
                  getTitleText('Ingredients'),
                  SizedBox(
                    height: 15,
                  ),
                  ...getIngredients(),
                  SizedBox(
                    height: 24,
                  ),
                  getTitleText('Steps'),
                  SizedBox(
                    height: 15,
                  ),
                  ...getCookingSteps(),
                ],
              );
            }),
          ),
        ],
      ),
    
 */
/* 

 */
