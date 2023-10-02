import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/home/widgets/all_exercises_widget/widget/loaded_state_widget.dart';
import 'all_exercises.dart';

class AllExercisesWidget extends StatefulWidget {
  const AllExercisesWidget({super.key, required this.title});
  final String title;

  @override
  State<AllExercisesWidget> createState() => _AllExercisesWidgetState();
}

class _AllExercisesWidgetState extends State<AllExercisesWidget> {


  @override
  void initState() {
    BlocProvider.of<AllExercisesBloc>(context).add(LoadAllExercises());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExercisesLoaded) {
            return LoadedStateWidget(title: widget.title, exercises: state.exercises);
          }
          else if (state is ExerciseOperationSuccess) {
            allExercisesBloc.add(LoadAllExercises());
            return Container();
          }
          else if (state is ExerciseOperationFailure) {
            return Center(child: Text(state.message));
          }
          else{
            return Container();
          }
        }
      );
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //     showAddExerciseDialog(context, allExercisesBloc);
          //   },
          //     child: const Icon(Icons.add),
          // ),

  }

  void showAddExerciseDialog(BuildContext context, AllExercisesBloc _allExercisesBloc) {
    final _titleController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add exercise"),
            content: TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Todo title'),
            ),
            actions: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  final exercise = Exercise(
                    id: DateTime.now().toString(),
                    name: _titleController.text,
                    veryfied: false,
                    photo_url: "",
                    description: "nawalanie mlotem",
                    adding_user_id: "",
                    body_part_id: 1,
                  );
                  _allExercisesBloc.add(AddExercise(exercise));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }
}



