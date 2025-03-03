// ignore_for_file: public_member_api_docs, sort_constructors_first
class MealModel {
  final String id;
  final String title;
  final String drinkAlternate;
  final String category;
  final String area;
  final List<String> instructions;
  final String imageUrl;
  final String videoUrl;
  final String tags;
  List<Map<String, String>> ingredients;

  MealModel({
    required this.id,
    required this.title,
    required this.drinkAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.videoUrl,
    required this.tags,
    required this.ingredients,
  });

}
