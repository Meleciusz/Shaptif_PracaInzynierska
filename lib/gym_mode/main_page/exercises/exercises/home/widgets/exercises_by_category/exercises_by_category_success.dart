import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'exercises_by_category_item.dart';

/*
 * Main description:
This class describes look of exercises by category widget
 */
class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key, required this.exercisesByCategory});

  final List<Exercise> exercisesByCategory;



  @override
  Widget build(BuildContext context) {
    return exercisesByCategory.isNotEmpty ?
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //show list of exercises by category
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          child: ListView.separated(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
            ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ExerciseByCategoryItem(
                  exercise: exercisesByCategory[index],
                  //allExerciseBloc: allExerciseBloc,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 25),
              itemCount: exercisesByCategory.length
          ),
        )
      ]
    )

        //if no exercises are found in this category show this text
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No exercises", style: Theme.of(context).textTheme.bodySmall,),
        const SizedBox(height: 50,),
      ]
    );
  }
}