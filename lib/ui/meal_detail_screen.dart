import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saham_rakyat/bloc/meal_detail_bloc.dart';

import '../api/api_service.dart';
import '../model/meal_detail.dart';
import '../repository/meal_detail_repository.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;

  MealDetailScreen({required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
      ),
      body: BlocProvider(
        create: (context) =>
            MealDetailBloc(repository: MealDetailRepository(ApiService(Dio())))
              ..add(FetchMealDetail(mealId: mealId)),
        child: BlocBuilder<MealDetailBloc, MealDetailState>(
          builder: (context, state) {
            if (state is MealDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MealDetailLoaded) {
              return _buildMealDetail(state.mealDetail);
            } else if (state is MealDetailError) {
              return Center(child: Text('Error loading meal detail'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildMealDetail(MealDetail mealDetail) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mealDetail.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(mealDetail.imageUrl),
          ),
          SizedBox(height: 24),
          Text(
            'Ingredients',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mealDetail.ingredients
                .map((ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "-" + ingredient,
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 24),
          Text(
            'Instructions',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            mealDetail.instructions,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
