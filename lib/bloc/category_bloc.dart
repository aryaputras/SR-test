import 'dart:async';
import 'package:bloc/bloc.dart';

import '../model/category.dart';
import '../model/meal.dart';
import '../repository/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    on<CategorySelected>(_onCategorySelected);
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onCategorySelected(
      CategorySelected event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final List<Meal> meals =
          await categoryRepository.getMealsByCategory(event.categoryName);
      final List<Category> categories =
          await categoryRepository.getCategories();
      emit(CategoryLoaded(categories: categories, meals: meals));
    } catch (error) {
      emit(CategoryError(error.toString()));
    }
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final List<Category> categories =
          await categoryRepository.getCategories();
      if (categories.isNotEmpty) {
        final String firstCategory = categories.first.strCategory;
        final List<Meal> meals =
            await categoryRepository.getMealsByCategory(firstCategory);
        emit(CategoryLoaded(categories: categories, meals: meals));
      } else {
        emit(CategoryLoaded(categories: [], meals: []));
      }
    } catch (error) {
      emit(CategoryError('Error fetching categories: $error'));
    }
  }
}
