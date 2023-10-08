import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import '../../../../../ExerciseDescription/exercises_description.dart';
import 'all_exercises.dart';

class AllExerciseBoard extends StatelessWidget {
const AllExerciseBoard({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ExerciseDescription(exercise: exercise)
            )
          );
      },
      child: Container(
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(.1),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.0,
            top: 15.0,
            bottom: 15.0,
            child: ExerciseBodyPartImage(image: exercise.photo_url ?? ""),
          ),
          Positioned(
            top: 25.0,
            left: 100.0,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(
                exercise.name ?? "",
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
              top: 65.0,
              left: 100.0,
              child: ExerciseVeryfiedIcon(
                veryfied: exercise.veryfied,
              )
          ),
        ],
      ),
      ),
    );
  }
}