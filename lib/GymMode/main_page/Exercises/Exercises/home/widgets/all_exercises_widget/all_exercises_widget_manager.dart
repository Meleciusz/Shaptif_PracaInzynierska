import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/Exercises/home/widgets/all_exercises_widget/widget/success_widget.dart';
import 'all_exercises.dart';

class AllExercisesWidget extends StatelessWidget {
  const AllExercisesWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder:  (context, state){
          return state.status.isSuccess
              ? LoadedStateWidget(exercises: state.exercises, title: title)
              : state.status.isLoading
                ? const Center(child:  CircularProgressIndicator(),)
                : state.status.isError
                  ? const Center(child: Text("Error"))
                  : const SizedBox();
      }
    );
  }
}



