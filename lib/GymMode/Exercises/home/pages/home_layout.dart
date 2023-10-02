import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/home/widgets/header_title/header_title.dart';
import '../../widgets/container_body.dart';
import '../widgets/all_exercises_widget/all_exercises.dart';


class HomeLayout extends StatelessWidget {
const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTitle(),
          SizedBox(height: 20),
          ContainerBody(
            children:[
              AllExercisesWidget(title: 'All exercises'),
            ]
          )
        ],
      )
    );
  }
}



