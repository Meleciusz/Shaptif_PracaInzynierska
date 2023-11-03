import 'package:authorization_repository/authorization_repository.dart';
import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';
import '../home.dart';
import '../widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import 'home_layout.dart';

class HomePageGym extends StatelessWidget {
  const HomePageGym({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePageGym());

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirestoreExerciseService(),
        ),
        RepositoryProvider(
          create: (context) => FirestoreBodyPartsService(),
        )
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<AllExercisesBloc>(
              create: (context) => AllExercisesBloc(
                firestoreService: context.read<FirestoreExerciseService>(),
              )..add(GetExercises())
          ),
          BlocProvider<CategoryBloc>(
              create: (context) => CategoryBloc(
                firestoreService: context.read<FirestoreBodyPartsService>(),
              )..add(GetCategories())
          ),
          BlocProvider<ExercisesByCategoryBloc>(
              create: (context) => ExercisesByCategoryBloc(
                firestoreService: context.read<FirestoreExerciseService>(),
              )
          ),
        ],
        child: const HomeLayout(),
      ),
    );
  }
}