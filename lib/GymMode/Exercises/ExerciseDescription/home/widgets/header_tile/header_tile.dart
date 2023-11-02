import 'dart:developer';

import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';

import '../../../../../../authorization/app/app.dart';
import '../../../../Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';

const _avatarSize = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.veryfied, required this.addingUser, required this.exerciseId, required this.contextBloc});
  final bool veryfied;
  final String addingUser;
  final String exerciseId;
  final AllExercisesBloc contextBloc;



  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    log(user.toString());

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
          contextBloc.add(DeleteExercise(exerciseID: exerciseId));
          contextBloc.add(RefreshExercises());
          Navigator.pop(context);
        }, icon: const Icon(Icons.delete_forever, size: _avatarSize)) :
        const SizedBox(),
      ],
    );
  }
}