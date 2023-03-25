import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saham_rakyat/bloc/meal_detail_bloc.dart';
import 'package:saham_rakyat/model/meal_detail.dart';
import 'package:saham_rakyat/repository/meal_detail_repository.dart';

class MockMealDetailRepository extends Mock implements MealDetailRepository {}

void main() {
  late MealDetailBloc mealDetailBloc;
  late MockMealDetailRepository mockMealDetailRepository;

  setUp(() {
    mockMealDetailRepository = MockMealDetailRepository();
    mealDetailBloc = MealDetailBloc(repository: mockMealDetailRepository);
  });

  tearDown(() {
    mealDetailBloc.close();
  });

  test('initial state is MealDetailInitial', () {
    expect(mealDetailBloc.state, MealDetailInitial());
  });

  blocTest<MealDetailBloc, MealDetailState>(
    'emits [MealDetailLoading, MealDetailLoaded] when FetchMealDetail event is added',
    build: () {
      final mealDetail = MealDetail(
        id: '1',
        name: 'Meal 1',
        imageUrl: "",
        instructions: 'Cook meal 1',
        area: '',
        category: '',
        ingredients: [],
        measures: [],
      );
      when(() => mockMealDetailRepository.fetchMealDetail('1'))
          .thenAnswer((_) async => mealDetail);
      return mealDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMealDetail(mealId: '1')),
    expect: () => [
      MealDetailLoading(),
      MealDetailLoaded(
          mealDetail: MealDetail(
        id: '1',
        name: 'Meal 1',
        imageUrl: "",
        instructions: 'Cook meal 1',
        area: '',
        category: '',
        ingredients: [],
        measures: [],
      )),
    ],
  );

  blocTest<MealDetailBloc, MealDetailState>(
    'emits [MealDetailLoading, MealDetailError] when an exception occurs',
    build: () {
      when(() => mockMealDetailRepository.fetchMealDetail('1'))
          .thenThrow(Exception('API error'));
      return mealDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMealDetail(mealId: '1')),
    expect: () => [
      isA<MealDetailLoading>(),
      isA<MealDetailError>(),
    ],
  );
}
