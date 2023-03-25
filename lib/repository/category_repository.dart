import '../api/api_service.dart';
import '../model/category.dart';
import '../model/meal.dart';

class CategoryRepository {
  final ApiService apiService;

  CategoryRepository({required this.apiService});

  Future<List<Category>> getCategories() async {
    final response = await apiService.getCategories();
    return response;
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    return await apiService.getMealsByCategory(category);
  }
}
