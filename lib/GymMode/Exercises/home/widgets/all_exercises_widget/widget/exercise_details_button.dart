import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

class ExerciseDetailsButton extends StatelessWidget {
  const ExerciseDetailsButton({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //         builder: (context) => ExerciseDetailsPage(exercise: exercise))
        // );
      },
      style: ElevatedButton.styleFrom(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        backgroundColor: Colors.orangeAccent,
        minimumSize: const Size(50, 20),
      ),
      child: const Text('Details', style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
    );
  }
}