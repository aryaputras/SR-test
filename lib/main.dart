import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';
import 'package:saham_rakyat/api/api_client.dart';
import 'package:saham_rakyat/api/api_service.dart';
import 'package:saham_rakyat/bloc/category_bloc.dart';
import 'package:saham_rakyat/repository/category_repository.dart';
import 'package:saham_rakyat/ui/meal_list_screen.dart';

void main() {
  final dio = Dio();
  final apiService = ApiService(dio);
  final categoryRepository = CategoryRepository(apiService: apiService);

  runApp(MyApp(
    categoryRepository: categoryRepository,
  ));
}

class MyApp extends StatelessWidget {
  final CategoryRepository categoryRepository;

  MyApp({required this.categoryRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) =>
            CategoryBloc(categoryRepository: categoryRepository),
        child: MealListScreen(),
      ),
    );
  }
}
