import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

import 'exercises_by_category_item.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key, required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return exercises.isNotEmpty ?
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              bottom: 16.0,
            ),
          child: Text(exercises.first.body_parts.first.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .2,
          child: ListView.separated(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
            ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ExerciseByCategoryItem(
                  exercise: exercises[index],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 25),
              itemCount: exercises.length
          ),
        )
      ]
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No exercises", style: Theme.of(context).textTheme.bodySmall,),
        SizedBox(height: 50,),
      ]
    );
  }
}