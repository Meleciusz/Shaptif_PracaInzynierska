import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/home/widgets/all_exercises_widget/all_exercises.dart';
import 'package:exercise_repository/exercise_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AllExercisesBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = BlocProvider.of<AllExercisesBloc>(context);
    _todoBloc.add(LoadAllExercises());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
      ),
      body: BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is ExercisesLoaded) {
            return AllExercisesWidget(title: '');
          }
          else if (state is ExerciseOperationSuccess) {
            _todoBloc.add(LoadAllExercises());
            return Container();
          }
          else if (state is ExerciseOperationFailure) {
            return Center(child: Text(state.message));
          }
          else{
            return Container();
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddTodoDialog(context, _todoBloc);
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
             _todoBloc.add(RefreshExercises());
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }


  void _showAddTodoDialog(BuildContext context, AllExercisesBloc _todoBloc) {
    final _titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
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
                final todo = Exercise(
                  id: DateTime.now().toString(),
                  name: _titleController.text,
                  veryfied: false,
                  photo_url: "",
                  description: "nawalanie mlotem",
                  adding_user_id: "",
                  body_part_id: 1,
                );
                _todoBloc.add(AddExercise(todo));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
