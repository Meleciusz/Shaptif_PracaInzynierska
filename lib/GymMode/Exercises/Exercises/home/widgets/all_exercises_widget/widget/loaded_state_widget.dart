import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';
import 'all_exercise_board.dart';

class LoadedStateWidget extends StatelessWidget {
  const LoadedStateWidget({super.key, required this.exercises, required this.title});
  final String title;
  final List<Exercise>? exercises;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: ((exercises!.length * 100) + MediaQuery.of(context).size.width) + 24,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 24.0,
                    ),
                    itemBuilder: (context, index) {
                      return AllExerciseBoard(
                            exercise: exercises![index],
                          );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 20.0,
                    ),
                    itemCount: exercises!.length),
              ),
            ],
          );
        }
    );
  }

}