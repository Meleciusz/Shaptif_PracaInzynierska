import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../bloc/new_training_bloc.dart';

class NewTrainingManager extends StatelessWidget {
  const NewTrainingManager({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTrainingBloc, NewTrainingState>(
        builder: (context, state) {
          return state.status.isSuccess
              ? NewTrainingSuccess(allExercises: state.exercises)
              : state.status.isLoading
              ? const Center(child: CircularProgressIndicator(),)
              : state.status.isError
              ? const Center(child: Text('Error'),)
              : const SizedBox();
        }
    );
  }
}