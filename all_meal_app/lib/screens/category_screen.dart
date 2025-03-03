import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/models/category_model.dart';
import 'package:all_meal_app/screens/meal_screen.dart';
import 'package:all_meal_app/services/category_meals_service.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryMealModel> categoryMealList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoryMealsList();
  }

  Future<void> getCategoryMealsList() async {
    final data = await CategoryMealsService.getCategotyModels(widget.category);
    setState(() {
      categoryMealList = data;
      isLoading = false;
    });
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(widget.category.title),
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
      body: Container(
        decoration: ConstantColors.gradientContainer,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Hero(
                    tag: widget.category.id,
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(widget.category.imageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Text(
                      widget.category.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Dishes',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            if (isLoading)
              SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())),
            if (!isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final categoryMeal = categoryMealList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
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
                  childCount: categoryMealList.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
