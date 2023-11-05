import 'package:flutter/material.dart';
import 'package:training_repository/training_repository.dart';

import 'item.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({
    super.key,
    required this.trainingsByCategory,
    required this.categoryName,
  });

  final List<Training> trainingsByCategory;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return trainingsByCategory.isNotEmpty ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TrainingsByCategoryItem(
                      training: trainingsByCategory[index],
                      //allExerciseBloc: allExerciseBloc,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 25),
                  itemCount: trainingsByCategory.length
              ),
            )
          ],
        ) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No trainings", style: Theme.of(context).textTheme.bodySmall,),
          const SizedBox(height: 50,),
        ]
    );
  }
}