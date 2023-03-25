import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/category.dart';
import '../model/meal.dart';
import '../model/meal_detail.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);
  static ApiService create() {
    final Dio dio = Dio();
    return ApiService(dio);
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio
          .get('https://www.themealdb.com/api/json/v1/1/list.php?c=list');
      if (response.statusCode == 200) {
        List<Category> categories = [];
        (response.data['meals'] as List).forEach((element) {
          categories.add(Category.fromJson(element));
        });
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      final response = await _dio.get(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
      if (response.statusCode == 200) {
        List<Meal> meals = [];
        (response.data['meals'] as List).forEach((element) {
          meals.add(Meal.fromJson(element));
        });
        return meals;
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<MealDetail> getMealDetail(String mealId) async {
    try {
      final response = await _dio
          .get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId');
      if (response.statusCode == 200) {
        MealDetail mealDetail = MealDetail.fromJson(response.data['meals'][0]);
        return mealDetail;
      } else {
        throw Exception('Failed to load meal detail');
      }
    } catch (e) {
      throw Exception('Failed to load meal detail: $e');
    }
  }
}
