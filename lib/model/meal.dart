import 'dart:convert';

class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }

  static List<Meal> fromJsonList(dynamic jsonList) {
    if (jsonList == null) {
      return [];
    }
    return List<Meal>.from(jsonList.map((x) => Meal.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        'idMeal': idMeal,
        'strMeal': strMeal,
        'strMealThumb': strMealThumb,
      };
}

String mealToJson(Meal data) => json.encode(data.toJson());

List<Meal> mealListFromJson(String str) =>
    Meal.fromJsonList(json.decode(str)['meals']);

String mealListToJson(List<Meal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
