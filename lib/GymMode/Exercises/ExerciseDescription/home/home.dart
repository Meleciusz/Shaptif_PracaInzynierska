import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

class ExerciseDescription extends StatelessWidget {
  const ExerciseDescription({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(exercise.name ?? ""),
        ]
      ),
    );
  }
}