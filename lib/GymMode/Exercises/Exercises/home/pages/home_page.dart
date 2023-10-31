import 'package:authorization_repository/authorization_repository.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/exercises.dart';
import '../widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import 'home_layout.dart';

class HomePageGym extends StatelessWidget {
  const HomePageGym({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: RepositoryProvider(
        create: (context) => FirestoreExerciseService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AllExercisesBloc>(
                create: (context) => AllExercisesBloc(
                  firestoreService: context.read<FirestoreExerciseService>(),
                )..add(GetExercises())
            )
          ],
          child: const HomeLayout(),
        ),
      )
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider<AllExercisesBloc>(
      //         create: (context) => AllExercisesBloc(FirestoreExerciseService())
      //     ),
      //     BlocProvider<CategoryWidgetBloc>(
      //       create: (context) => CategoryWidgetBloc(FirestoreExerciseService(), FirestoreBodyPartsService()),
      //     ),
      //     BlocProvider<ExercisesByCategoryBloc>(
      //       create: (context) => ExercisesByCategoryBloc(FirestoreExerciseService(), FirestoreBodyPartsService()),
      //     )
      //   ],
      //   child: const HomeLayout(),
      // ),
    );
  }
}