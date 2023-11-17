import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/bloc/main_page_bloc.dart';
import 'package:shaptifii/GymMode/main_page/main_page.dart';

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