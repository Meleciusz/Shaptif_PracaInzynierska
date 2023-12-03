import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../exercise_description/exercises_description.dart';
import '../../exercises_by_category/exercises_by_category.dart';
import '../bloc/all_exercises_bloc.dart';
import 'all_exercises.dart';


/*
 * Main description:
This class describes item of all exercises

* Navigator:
User can navigate to exercise description
 */
class AllExerciseItem extends StatelessWidget {
const AllExerciseItem({super.key, required this.exercise});
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    final ExercisesByCategoryBloc exercisesByCategoryBloc = BlocProvider.of<ExercisesByCategoryBloc>(context);

    return BlocBuilder<AllExercisesBloc, AllExercisesState>(
        builder: (context, state){
          return GestureDetector(

            //navigate to exercise description
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ExerciseDescription(exercise: exercise, allExercisesBloc: allExercisesBloc,
                        exercisesByCategoryBloc: exercisesByCategoryBloc
                      )
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
                    top: 25.0,
                    left: 20.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: Text(
                        exercise.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 65.0,
                      left: 100.0,
                      child: ExerciseVerifiedIcon(
                        verified: exercise.verified,
                        addingUserName: exercise.adding_user_name,
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}