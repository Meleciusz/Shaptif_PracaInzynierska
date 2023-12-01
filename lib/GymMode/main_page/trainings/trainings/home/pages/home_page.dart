import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../widgets/category_widget/category_widget.dart';
import 'home_layout.dart';


/*
 * Main description:
This is the home page
This class is used to provide bloc and repository to layout
 */
class HomePageTrainings extends StatelessWidget {
  const HomePageTrainings({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePageTrainings());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

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
                )..add(GetAllTrainings(userID: user.id))
            ),
            BlocProvider(
                create: (context) => CategoryBloc(
                  firestoreService: context.read<FirestoreBodyPartsService>(),
                )..add(GetCategories())
            ),
          ],
          child: const HomeLayout(),
        )
    );
  }
}
