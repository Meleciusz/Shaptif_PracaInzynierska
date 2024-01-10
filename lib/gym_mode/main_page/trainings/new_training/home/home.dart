import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/gym_mode/main_page/trainings/new_training/bloc/new_training_bloc.dart';
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
          RepositoryProvider(
            create: (context) => FirestoreBodyPartsService(),
          ),
        ],
        child: BlocProvider<NewTrainingBloc>(
            create: (context) => NewTrainingBloc(
              bodyPartsService: context.read<FirestoreBodyPartsService>(),
              trainingRepository: context.read<FirestoreTrainingService>(),
              exerciseRepository: context.read<FirestoreExerciseService>(),
            )..add(GetExercises())
            ..add(GetBodyParts()),
                child: const NewTrainingManager(),
        ),
    );
  }
}
