import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/meal_detail.dart';
import '../repository/meal_detail_repository.dart';
part 'meal_detail_event.dart';
part 'meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final MealDetailRepository repository;

  MealDetailBloc({required this.repository}) : super(MealDetailInitial()) {
    on<FetchMealDetail>(_onFetchMealDetail);
  }

  Future<void> _onFetchMealDetail(
      FetchMealDetail event, Emitter<MealDetailState> emit) async {
    emit(MealDetailLoading());
    try {
      final MealDetail mealDetail =
          await repository.fetchMealDetail(event.mealId);
      emit(MealDetailLoaded(mealDetail: mealDetail));
    } catch (error) {
      emit(MealDetailError(message: error.toString()));
    }
  }
}
