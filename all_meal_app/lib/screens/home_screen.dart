import 'package:all_meal_app/providers/search_provider.dart';
import 'package:all_meal_app/screens/favourite_meals_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/common/title_text.dart';
import 'package:all_meal_app/screens/category_list_screen.dart';
import 'package:all_meal_app/screens/meal_list_screen.dart';
import 'package:all_meal_app/screens/side_drawer.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    CategoryListScreen(),
    MealListScreen(),
    FavouriteMealsListScreen(),
  ];
  List<String> titles = [
    'All Categories',
    'All Meals',
    'Favourite Meals',
  ];

  final TextEditingController _searchController = TextEditingController();

  int _currentIndex = 0;
  late Widget currentScreen;
  bool _isSearchOn = false;
  bool isNavbarAndAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    currentScreen = screens[_currentIndex];
  }

  void _onSearch(String searc) {
    String search = _searchController.text.trim();
    Provider.of<SearchProvider>(context, listen: false).setSearchText(search);
  }

  @override
  void dispose() {
    _searchController.dispose();
    Provider.of<SearchProvider>(context, listen: false).setSearchText('');
    super.dispose();
  }

  void _navigateToScreen() {
    Widget screen = screens[_currentIndex];
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: isNavbarAndAppBarVisible
      //     ? AppBar(
      //         title: CustomText(title: titles[_currentIndex]).toTitleText(),
      //         actions: [
      //           if (_currentIndex == 1)
      //             IconButton(
      //               iconSize: 35.0,
      //               color: Colors.blueAccent,
      //               onPressed: () {
      //                 setState(() {
      //                   _isSearchOn = !_isSearchOn;
      //                 });
      //               },
      //               icon: Icon(Icons.search),
      //             ),
      //         ],
      //         centerTitle: true,
      //         flexibleSpace: Container(
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               begin: Alignment.topCenter,
      //               end: Alignment.bottomCenter,
      //               colors: <Color>[
      //                 ConstantColors.ScaffoldBgColor,
      //                 Colors.white,
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     : AppBar(
      //         backgroundColor: Colors.transparent,
      //         foregroundColor: Colors.transparent,
      //       ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (scroll) {
          if (scroll.direction == ScrollDirection.forward) {
            setState(() {
              isNavbarAndAppBarVisible = true;
            });
          }
          if (scroll.direction == ScrollDirection.reverse) {
            setState(() {
              isNavbarAndAppBarVisible = false;
            });
          }
          return true;
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: CustomText(title: titles[_currentIndex]).toTitleText(),
                actions: [
                  if (_currentIndex == 1)
                    IconButton(
                      iconSize: 35.0,
                      color: Colors.blueAccent,
                      onPressed: () {
                        setState(() {
                          _isSearchOn = !_isSearchOn;
                        });
                      },
                      icon: Icon(Icons.search),
                    ),
                ],
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        ConstantColors.ScaffoldBgColor,
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              if (_isSearchOn && _currentIndex == 1)
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SizedBox(
                      height: 56,
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) => _onSearch(value),
                        onChanged: (value) => _onSearch(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(child: currentScreen),
            ],
          ),
        ),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: isNavbarAndAppBarVisible
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Colors.white,
              onTap: (value) => setState(() {
                _currentIndex = value;
                _navigateToScreen();
              }),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.food_bank),
                  label: 'Meals',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourite',
                ),
              ],
            )
          : SizedBox(),
    );
  }
}
