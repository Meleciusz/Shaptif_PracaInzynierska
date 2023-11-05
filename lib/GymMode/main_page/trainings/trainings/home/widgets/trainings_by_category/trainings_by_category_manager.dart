import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/trainings_by_category/bloc/trainings_by_category_bloc.dart';
import 'widgets/success_widget.dart';

class TrainingsByCategory extends StatelessWidget {
  const TrainingsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingsByCategoryBloc, TrainingsByCategoryState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? CategoriesSuccessWidget(trainingsByCategory: state.trainings, categoryName: state.categoryName)
            : state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.status.isError
                    ? const Center(child: Text("Error"))
                    : const SizedBox();
      }
    );
  }
}
