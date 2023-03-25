import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saham_rakyat/api/api_service.dart';
import 'package:saham_rakyat/model/category.dart';
import 'package:saham_rakyat/model/meal.dart';

class MockDio extends Mock implements Dio {}

Map<String, dynamic> _categoryToJson(Category category) {
  return {
    'idCategory': category.idCategory,
    'strCategory': category.strCategory,
    'strCategoryDescription': category.strCategoryDescription,
    'strCategoryThumb': category.strCategoryThumb,
  };
}

void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
    registerFallbackValue(Uri());
  });

  test('getMealsByCategory throws an exception if API call fails', () async {
    // Arrange
    final String categoryId = '1';
    when(() => mockDio.get(any())).thenThrow(Exception('API error'));

    // Act & Assert
    expect(() async => await apiService.getMealsByCategory(categoryId),
        throwsA(isA<Exception>()));
    verify(() => mockDio.get(any())).called(1);
  });

  test('getCategories throws an exception if API call fails', () async {
    // Arrange
    when(() => mockDio.get(any())).thenThrow(Exception('API error'));

    // Act & Assert
    expect(() async => await apiService.getCategories(),
        throwsA(isA<Exception>()));
    verify(() => mockDio.get(any())).called(1);
  });
}
