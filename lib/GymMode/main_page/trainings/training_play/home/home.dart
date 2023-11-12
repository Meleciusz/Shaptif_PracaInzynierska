import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import 'package:training_repository/training_repository.dart';

import 'training_play_manager.dart';

class TrainingPlay extends StatelessWidget {
  const TrainingPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => FirestoreTrainingService(),
          ),
          RepositoryProvider(
            create: (context) => FirestoreExerciseService(),
          ),
        ],
        child: BlocProvider<TrainingPlayBloc>(
          create: (context) => TrainingPlayBloc(
            trainingRepository: context.read<FirestoreTrainingService>(),
            exerciseRepository: context.read<FirestoreExerciseService>(),
          )..add(GetTrainings()),
          child: const TrainingPlayManager(),
        )
    );
  }
}