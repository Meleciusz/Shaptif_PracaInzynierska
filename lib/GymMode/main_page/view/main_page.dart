import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/main_page.dart';

/*
 * Main description:
This is the home page
This class is used to provide bloc and repository to layout
 */
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: const MainPageView(),
    );
  }
}

/*
 * Main description:
This is layout
This class define what is displayed on screen


FlowBuilder is used to define what is displayed on screen(exercises or trainings)
onGenerateExerciseAndTrainingPages define routes
 */
class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder<MainPageStatus>(
        state: context.select((MainPageBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateExerciseAndTrainingPages
      ),
    );
  }
}