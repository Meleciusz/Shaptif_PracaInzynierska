import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';

/*
 * Main description:
 This class build screen basing on bloc state
 */
class AllTrainingsWidget extends StatelessWidget {
  const AllTrainingsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AllTrainingsBloc, AllTrainingsState>(
        builder: (context, state){
          return state.status.isSuccess
              ? TrainingsSuccessWidget(trainings: state.trainings)
              : state.status.isLoading
                ? const Center(child: CircularProgressIndicator(),)
                : state.status.isError
                  ? const Center(child: Text("Error"))
                  : const SizedBox();
        }
    );
  }
}