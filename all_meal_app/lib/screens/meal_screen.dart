import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/category_meal_model.dart';
import 'package:all_meal_app/models/meal_model.dart';
import 'package:all_meal_app/providers/favourite_meals_provider.dart';
import 'package:all_meal_app/services/meal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({
    super.key,
    required this.categoryMeal,
  });

  final CategoryMealModel categoryMeal;
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  MealModel? meal;
  bool isLoading = false;
  bool isFavourite = false;
  String? videoId = '';
  YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: '');

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getMealById();
    isFavourite = Provider.of<FavouriteMealsProvider>(context, listen: false)
        .isFavourite(widget.categoryMeal);
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _addToFavourite() {
    Provider.of<FavouriteMealsProvider>(context, listen: false)
        .addToFavourites(widget.categoryMeal);
  }

  void getMealById() async {
    final data = await MealService.getSingleMealById(widget.categoryMeal.id);
    setState(() {
      videoId = YoutubePlayer.convertUrlToId(data.videoUrl);
      meal = data;
      isLoading = false;
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
    });
  }

  Widget getTitleText({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: ConstantColors.TitleTextColor,
      ),
      textAlign: TextAlign.left,
    );
  }

  List<Widget> getIngredients(
      {required List<Map<String, String>> ingredients}) {
    List<Widget> res = [];
    int index = 0;
    for (int i = 0; i < ingredients.length; i++) {
      final ingredient = ingredients[i];
      index++;
      final wid = SizedBox(
        height: null,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$index',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${ingredient.values.first}',
                  textAlign: TextAlign.justify,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${ingredient.values.last}',
                  textAlign: TextAlign.justify,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      res.add(wid);
    }
    return res;
  }

  List<Widget> getInstructions({required List<String> instructions}) {
    List<Widget> instrWid = [];

    int index = 0;
    for (int i = 0; i < instructions.length; i++) {
      final instruction = instructions[i];
      if (instruction.isNotEmpty && !instruction.contains('STEP')) {
        index++;
        final wid = SizedBox(
          height: null,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$index',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    instruction,
                    textAlign: TextAlign.justify,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        instrWid.add(wid);
      }
    }

    return instrWid;
  }

  Widget getInfo({required String info, required String key}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$key : $info',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  List<Widget> getAdditionalInfo({required MealModel meal}) {
    List<Widget> res = [];
    Widget category = getInfo(key: 'Category', info: meal.category);
    res.add(category);
    Widget area = getInfo(key: 'Area', info: meal.area);
    res.add(area);
    if (meal.drinkAlternate.isNotEmpty) {
      Widget drinkAlternate =
          getInfo(key: 'Drink Alt', info: meal.drinkAlternate);
      res.add(drinkAlternate);
    }
    if (meal.tags.isNotEmpty) {
      Widget tags = getInfo(key: 'Tags', info: meal.tags);
      res.add(tags);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    isFavourite = Provider.of<FavouriteMealsProvider>(context)
        .isFavourite(widget.categoryMeal);
    Widget content = Container(
      decoration: ConstantColors.gradientContainer,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (!isLoading) {
      content = Container(
        decoration: ConstantColors.gradientContainer,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (meal?.videoUrl == null || meal!.videoUrl.isEmpty)
                      Hero(
                        tag: meal!.id,
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Image.network(meal!.imageUrl),
                        ),
                      ),
                    if (!(meal?.videoUrl == null || meal!.videoUrl.isEmpty))
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.red,
                        ),
                        onReady: () {
                        },
                      ),
                    getTitleText(text: 'Ingredients'),
                    Column(
                      children: [
                        ...getIngredients(ingredients: meal!.ingredients),
                      ],
                    ),
                    getTitleText(text: 'Instructions'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...getInstructions(instructions: meal!.instructions),
                      ],
                    ),
                    getTitleText(text: 'Additional Info'),
                    Column(
                      children: [
                        ...getAdditionalInfo(meal: meal!),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: getTitleText(text: widget.categoryMeal.title),
        actions: [
          IconButton(
            onPressed: _addToFavourite,
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
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
      body: content,
    );
  }
}
