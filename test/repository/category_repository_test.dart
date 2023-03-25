import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saham_rakyat/api/api_service.dart';
import 'package:saham_rakyat/model/category.dart';
import 'package:saham_rakyat/repository/category_repository.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late CategoryRepository categoryRepository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    categoryRepository = CategoryRepository(apiService: mockApiService);
    registerFallbackValue(Uri());
  });

  test('getCategories returns a list of categories', () async {
    // Arrange
    final List<Category> categories = [
      Category(
          idCategory: '1',
          strCategory: 'Category 1',
          strCategoryDescription: '',
          strCategoryThumb: ''),
      Category(
          idCategory: '2',
          strCategory: 'Category 2',
          strCategoryDescription: '',
          strCategoryThumb: ''),
    ];
    when(() => mockApiService.getCategories())
        .thenAnswer((_) async => categories);

    // Act
    final result = await categoryRepository.getCategories();

    // Assert
    expect(result, categories);
    verify(() => mockApiService.getCategories()).called(1);
  });

  test('getCategories throws an exception if API call fails', () async {
    // Arrange
    when(() => mockApiService.getCategories())
        .thenThrow(Exception('API error'));

    // Act & Assert
    expect(() async => await categoryRepository.getCategories(),
        throwsA(isA<Exception>()));
    verify(() => mockApiService.getCategories()).called(1);
  });
}
