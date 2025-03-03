import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/constants/screen_filter_constant.dart';

import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/pages/all_meals_page.dart';
import 'package:meals_app/pages/categories_page.dart';
import 'package:meals_app/pages/filters_page.dart';
import 'package:meals_app/pages/meals_page.dart';
import 'package:meals_app/provider/favourite_meals_provider.dart';
import 'package:meals_app/provider/filter_provider.dart';
import 'package:meals_app/widgets/main_drawer.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegeterian: false,
};

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends ConsumerState<TabsPage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSetScreen(String identifier) {
    Navigator.of(context).pop();

    if (identifier == ScreenFilterConstant.FILTERS) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FiltersPage(),
        ),
      );
    } else if (identifier == ScreenFilterConstant.MEALS) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AllMealsPage(
            showAppbar: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMealsList = ref.watch(favouriteMealsProvider);
    final List<MealModel> availableMeals = ref.watch(filterMealsProvider);

    Widget activePage = CategoriesPage(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Select Category';

    if (_selectedPageIndex == 1) {
      activePage = AllMealsPage(
        showAppbar: false,
      );
      activePageTitle = 'All Meals';
    } else if (_selectedPageIndex == 2) {
      activePage = MealsPage(
        title: null,
        meals: favouriteMealsList,
      );
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _onSetScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            label: 'All Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
            ),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
