import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saham_rakyat/bloc/category_event.dart';

import '../api/api_service.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_state.dart';
import '../model/category.dart';
import '../model/meal.dart';
import '../repository/category_repository.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatefulWidget {
  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  late CategoryBloc _categoryBloc;
  String _selectedCategory = "Beef";

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(
        categoryRepository:
            CategoryRepository(apiService: ApiService.create()));
    _categoryBloc.add(FetchCategories());
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal App')),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: _categoryBloc,
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                _buildCategoryDropdown(state.categories),
                Expanded(child: _buildMealGridView(state.meals)),
              ],
            );
          } else {
            return Center(child: Text('Failed to load data'));
          }
        },
      ),
    );
  }

  Widget _buildCategoryDropdown(List<Category> categories) {
    return DropdownButton<String>(
      value: _selectedCategory,
      items: categories.map((Category category) {
        return DropdownMenuItem<String>(
          value: category.strCategory,
          child: Text(category.strCategory),
        );
      }).toList(),
      hint: Text('Select a category'),
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
        _categoryBloc.add(CategorySelected(categoryName: newValue!));
      },
    );
  }

  Widget _buildMealGridView(List<Meal> meals) {
    return GridView.builder(
      itemCount: meals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        final meal = meals[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetailScreen(mealId: meal.idMeal),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    meal.strMealThumb,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    meal.strMeal,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
