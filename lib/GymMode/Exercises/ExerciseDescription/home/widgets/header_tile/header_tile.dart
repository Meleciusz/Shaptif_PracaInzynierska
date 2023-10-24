import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/exercises.dart';

import '../../../../../../authorization/app/app.dart';

const _avatarSize = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.veryfied, required this.addingUser, required this.exerciseId, required this.allExercisesBloc});
  final bool veryfied;
  final String addingUser;
  final String exerciseId;
  final AllExercisesBloc allExercisesBloc;


  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: _avatarSize),
        ),
        const SizedBox(width: 30.0),
        user.name == addingUser ?
          veryfied ?
            const SizedBox() :
              IconButton(onPressed: (){
                allExercisesBloc.add(DeleteExercise(exerciseId));
                Navigator.pop(context);
              }, icon: const Icon(Icons.delete_forever, size: _avatarSize)) :
               const SizedBox(),
      ],
    );
  }
}