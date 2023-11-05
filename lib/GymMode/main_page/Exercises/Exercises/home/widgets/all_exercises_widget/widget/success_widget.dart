import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import 'all_exercise_item.dart';

class LoadedStateWidget extends StatefulWidget {
  const LoadedStateWidget(
      {super.key, required this.exercises, required this.title});

  final String title;
  final List<Exercise>? exercises;

  @override
  State<LoadedStateWidget> createState() => LoadedStateWidgetState();
}

class LoadedStateWidgetState extends State<LoadedStateWidget> {
  TextEditingController editingController = TextEditingController();

  List<Exercise> items = <Exercise>[];

  @override
  initState() {
    items = widget.exercises!;
    super.initState();
  }



  void filterSearchResults(value) {
    setState(() {
      items = widget.exercises!
          .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular((25.0)))
                      )
                  ),
                ),
              ),
              SizedBox(
                height: ((items.length * 100) + MediaQuery.of(context).size.width) + 24,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 24.0,
                    ),
                    itemBuilder: (context, index) {
                      return AllExerciseBoard(
                        exercise: items[index],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 20.0,
                    ),
                    itemCount: items.length),
              ),
            ],
          );
        }
    );
  }
}