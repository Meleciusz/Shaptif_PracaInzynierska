import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

import 'all_exercise_board.dart';

class LoadedStateWidget extends StatelessWidget {
  const LoadedStateWidget({super.key, required this.exercises, required this.title});
  final String title;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          height: ((exercises.length * 100) + MediaQuery.of(context).size.width) + 24,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return AllExerciseBoard(
                exercise: exercises[index],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: exercises.length),
        )
      ],
    );
  }

}