import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import '../widgets/widgets.dart';

class TrainingPlayManager extends StatelessWidget {
  const TrainingPlayManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingPlayBloc, TrainingPlayState>(
        builder: (context, state){
          return state.status.isSuccess
              ? TrainingPlaySuccess(allTrainings: state.trainings)
              : state.status.isLoading
              ? const Center(child: CircularProgressIndicator(),)
              : state.status.isError
              ? const Center(child: Text('Error'),)
              : const SizedBox();
        }
    );
  }
}