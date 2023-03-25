import 'package:equatable/equatable.dart';

class MealDetail extends Equatable {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> measures;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'];
      String measure = json['strMeasure$i'];

      if (ingredient.isNotEmpty) {
        ingredients.add(ingredient);
      }

      if (measure.isNotEmpty) {
        measures.add(measure);
      }
    }

    return MealDetail(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String,
      area: json['strArea'] as String,
      instructions: json['strInstructions'] as String,
      imageUrl: json['strMealThumb'] as String,
      ingredients: ingredients,
      measures: measures,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        category,
        area,
        instructions,
        imageUrl,
        ingredients,
        measures,
      ];
}
