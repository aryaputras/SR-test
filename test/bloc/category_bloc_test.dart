import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saham_rakyat/bloc/category_bloc.dart';
import 'package:saham_rakyat/bloc/category_event.dart';
import 'package:saham_rakyat/bloc/category_state.dart';
import 'package:saham_rakyat/model/category.dart';
import 'package:saham_rakyat/repository/category_repository.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late CategoryBloc categoryBloc;
  late MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    categoryBloc = CategoryBloc(categoryRepository: mockCategoryRepository);
  });

  tearDown(() {
    categoryBloc.close();
  });

  test('initial state is CategoryInitialState', () {
    expect(categoryBloc.state, CategoryInitial());
  });

  blocTest<CategoryBloc, CategoryState>(
    'emits [CategoryLoadingState, CategoryErrorState] when CategoryFetchEvent is added and an error occurs',
    build: () {
      when(() => mockCategoryRepository.getCategories())
          .thenThrow(Exception('API error'));
      return categoryBloc;
    },
    act: (bloc) => bloc.add(FetchCategories()),
    expect: () => [
      isA<CategoryLoading>(),
      isA<CategoryError>(),
    ],
  );
}
