import '../api/api_service.dart';
import '../model/meal_detail.dart';

class MealDetailRepository {
  final ApiService _apiService;

  MealDetailRepository(this._apiService);

  Future<MealDetail> fetchMealDetail(String mealId) async {
    print("fetch meal detail repo");
    final mealDetail = await _apiService.getMealDetail(mealId);

    return mealDetail;
  }
}
