import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/trainings_by_category/bloc/trainings_by_category_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../widgets/category_widget/category_widget.dart';

import 'home_layout.dart';

class HomePageTrainings extends StatelessWidget {
  const HomePageTrainings({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePageTrainings());

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => FirestoreTrainingService(),
          ),
          RepositoryProvider(
              create: (context) => FirestoreBodyPartsService(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AllTrainingsBloc>(
                create: (context) => AllTrainingsBloc(
                  firestoreService: context.read<FirestoreTrainingService>(),
                )..add(GetTrainings())
            ),
            BlocProvider(
                create: (context) => CategoryBloc(
                  firestoreService: context.read<FirestoreBodyPartsService>(),
                )..add(GetCategories())
            ),
            BlocProvider(
                create: (context) => TrainingsByCategoryBloc(
                    firestoreService: context.read<FirestoreTrainingService>(),
                ),
            )
          ],
          child: const HomeLayout(),
        )
    );
  }
}
