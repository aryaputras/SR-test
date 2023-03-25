import 'package:flutter_test/flutter_test.dart';
import 'package:saham_rakyat/api/api_service.dart';
import 'package:saham_rakyat/model/category.dart';
import 'package:saham_rakyat/model/meal.dart';
import 'dart:core';
import 'package:mocktail/mocktail.dart';

import 'package:saham_rakyat/model/meal_detail.dart';
import 'package:saham_rakyat/repository/meal_detail_repository.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MealDetailRepository mealDetailRepository;
  late MockApiService mockApiService;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockApiService = MockApiService();
    mealDetailRepository = MealDetailRepository(mockApiService);
  });

  test(
      'getMealDetail should return MealDetail when the call to ApiService is successful',
      () async {
    // Arrange
    final mealId = '52772';
    final expectedMealDetail = MealDetail(
      id: '52772',
      name: 'Chicken Parmesan',
      area: '',
      category: '',
      imageUrl: '',
      ingredients: [],
      instructions: '',
      measures: [],
    );

    when(() => mockApiService.getMealDetail(mealId))
        .thenAnswer((_) async => expectedMealDetail);

    // Act
    final result = await mealDetailRepository.fetchMealDetail(mealId);

    // Assert
    expect(result, equals(expectedMealDetail));
    verify(() => mockApiService.getMealDetail(mealId)).called(1);
  });

  test(
      'getMealDetail should throw an exception when the call to ApiService fails',
      () async {
    // Arrange
    final mealId = '52772';
    final exception = Exception('API error');

    when(() => mockApiService.getMealDetail(mealId)).thenThrow(exception);

    // Act
    Future<MealDetail> result = mealDetailRepository.fetchMealDetail(mealId);

    // Assert
    expect(() => result, throwsA(isA<Exception>()));
    verify(() => mockApiService.getMealDetail(mealId)).called(1);
  });
}
