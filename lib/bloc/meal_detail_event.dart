part of 'meal_detail_bloc.dart';

abstract class MealDetailEvent extends Equatable {
  const MealDetailEvent();
}

class FetchMealDetail extends MealDetailEvent {
  final String mealId;

  const FetchMealDetail({required this.mealId});

  @override
  List<Object> get props => [mealId];
}
