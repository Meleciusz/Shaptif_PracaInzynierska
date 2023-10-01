import 'package:flutter/material.dart';
import 'package:shaptifii/GymMode/Exercises/home/widgets/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: AllExercisesWidget(title: "All exercises")
    );
  }
}