import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../authorization/app/app.dart';
import '../../../../Exercises/home/widgets/all_exercises_widget/all_exercises.dart';
import '../../../../Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';


class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.verified, required this.addingUser,
    required this.exerciseId, required this.allExercisesBloc, required this.exercisesByCategoryBloc});
  final bool verified;
  final String addingUser;
  final String exerciseId;
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;



  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Transform.rotate(
              angle: 180 * 3.1416 / 180,
              child: const Icon(Icons.exit_to_app, size: 40),
            ),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Description", style: TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ), overflow: TextOverflow.ellipsis,),
            )
        ),
        user.name == addingUser ?
        verified ?
        const SizedBox() :
        IconButton(onPressed: (){
          allExercisesBloc.add(DeleteExercise(exerciseID: exerciseId));
          allExercisesBloc.add(RefreshExercises());
          exercisesByCategoryBloc.add(RefreshExercisesByCategory());
          Navigator.pop(context);
        }, icon: const Icon(Icons.delete_forever, size: 40)) :
        const SizedBox(),
      ],
    );
  }
}