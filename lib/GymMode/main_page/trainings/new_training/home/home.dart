import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/new_training/bloc/new_training_bloc.dart';
import 'package:training_repository/training_repository.dart';
import 'new_training_manager.dart';

/*
 * Main description:
This is the home page
This class is used to provide bloc and repository to layout
 */
class NewTrainingPage extends StatelessWidget {
  const NewTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => FirestoreExerciseService(),
          ),
          RepositoryProvider(
              create: (context) => FirestoreTrainingService(),
          ),
        ],
        child: BlocProvider<NewTrainingBloc>(
            create: (context) => NewTrainingBloc(
              trainingRepository: context.read<FirestoreTrainingService>(),
              exerciseRepository: context.read<FirestoreExerciseService>(),
            )..add(GetExercises()),
                child: const NewTrainingManager(),
        ),
    );
  }
}
