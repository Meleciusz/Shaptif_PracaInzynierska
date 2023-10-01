import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/all_exercises_bloc.dart';

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
    final AllExercisesBloc _allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    return Scaffold(
      body: BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExercisesLoaded) {
            final exercises = state.exercises;
            return ListView.builder(
              itemCount: exercises.length,
                itemBuilder: (context, index){
                final exercise = exercises[index];
                return ListTile(
                  title: Text(exercise.name),
                  leading: Checkbox(
                    value: exercise.veryfied,
                    onChanged: (_) {
                      //TODO: implement
                    },
                  ),
                );
                }
            );
          }
          else if (state is ExerciseOperationSuccess) {
            _allExercisesBloc.add(LoadAllExercises());
            return Container();
          }
          else if (state is ExerciseOperationFailure) {
            return Center(child: Text(state.message));
          }
          else{
            return Container();
          }
        }
      ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showAddExerciseDialog(context);
            },
              child: const Icon(Icons.add),
          ),
    );
  }
}

void showAddExerciseDialog(BuildContext context) {
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
              BlocProvider.of<AllExercisesBloc>(context).add(AddExercise(exercise));
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  );
}