import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/all_exercises_widget/widget/loaded_state_widget.dart';
import 'all_exercises.dart';

class AllExercisesWidget extends StatelessWidget {
  const AllExercisesWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder:  (context, state){
          return state.status.isSuccess
              ? LoadedStateWidget(exercises: state.exercises, title: title)
              : state.status.isLoading
                ? const Center(child:  CircularProgressIndicator(),)
                : state.status.isError
                  ? const Center(child: Text("Error"))
                  : const SizedBox();
      }
    );
    // final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    // return BlocBuilder<AllExercisesBloc, AllExercisesState>(
    //     builder: (context, state) {
    //       if (state is ExercisesLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is ExercisesLoaded) {
    //         return LoadedStateWidget(title: widget.title, exercises: state.exercises, allExerciseBloc: allExercisesBloc,);
    //       }
    //       else if (state is ExerciseOperationSuccess) {
    //         allExercisesBloc.add(LoadAllExercises());
    //         return Container();
    //       }
    //       else if (state is ExerciseOperationFailure) {
    //         return Center(child: Text(state.message));
    //       }
    //       else{
    //         return Container();
    //       }
    //     }
    //   );
  }
}



