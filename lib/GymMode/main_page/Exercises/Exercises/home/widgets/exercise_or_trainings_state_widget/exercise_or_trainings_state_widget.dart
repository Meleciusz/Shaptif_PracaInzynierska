import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/bloc/main_page_bloc.dart';

class ExerciseOrTrainingsStateWidget extends StatelessWidget {
  const ExerciseOrTrainingsStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final actualState = context.select((MainPageBloc bloc) => bloc.state);

    return BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: (){
                    context.read<MainPageBloc>().add(ChangeCategory());
                  },
                  child: actualState.status.isExercisesStatus
                      ? const Text("Trainings") : const Text("Exercises")
              ),
            ]
          );
        }
    );
  }
}