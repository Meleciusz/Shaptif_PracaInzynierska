import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/header_title/header_title.dart';
import '../../widgets/container_body.dart';
import '../widgets/all_exercises_widget/all_exercises.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);

    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(),
            SizedBox(height: 20),
            ContainerBody(
              children: [
                AllExercisesWidget(title: 'All exercises'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            allExercisesBloc.add(RefreshExercises());
          },
          child:  const Icon(Icons.refresh),
      ),
    );

  }
}

