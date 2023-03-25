import 'package:equatable/equatable.dart';

import '../model/category.dart';
import '../model/meal.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final List<Meal> meals;

  const CategoryLoaded({required this.categories, required this.meals});

  @override
  List<Object> get props => [categories, meals];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}
