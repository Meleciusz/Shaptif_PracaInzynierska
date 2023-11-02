import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';

import 'exercises_by_category_success.dart';

class ExercisesByCategory extends StatelessWidget {
  const ExercisesByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisesByCategoryBloc, ExercisesByCategoryState>(
        builder: (context, state) {
          return state.status.isSuccess
              ? CategoriesSuccessWidget(exercisesByCategory: state.exercises, categoryName: state.categoryName)
              : state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.status.isError
                  ? const Center(child: Text("Error"))
                  : const SizedBox();
        },
    );
  }
}