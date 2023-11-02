import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/exercises.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        buildWhen: (previous, current) => current.status.isSuccess,
        builder: (context, state) {
          return const CategoriesSuccessWidget();
      }
    );
  }
}
