import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_repository/history_repository.dart';
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
          RepositoryProvider(
            create: (context) => FirestoreHistoryService(),
          ),
        ],
        child: BlocProvider<TrainingPlayBloc>(
          create: (context) => TrainingPlayBloc(
            trainingRepository: context.read<FirestoreTrainingService>(),
            exerciseRepository: context.read<FirestoreExerciseService>(),
            historyRepository: context.read<FirestoreHistoryService>(),
          )..add(GetTrainingsAndExercises()),
          child: const TrainingPlayManager(),
        )
    );
  }
}