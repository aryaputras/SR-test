import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends CategoryEvent {}

class CategorySelected extends CategoryEvent {
  final String categoryName;

  const CategorySelected({required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}
