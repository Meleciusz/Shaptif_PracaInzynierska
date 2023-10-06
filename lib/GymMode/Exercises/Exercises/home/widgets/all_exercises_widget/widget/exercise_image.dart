import 'package:flutter/material.dart';
import 'package:shaptifii/home/home.dart';

class ExerciseBodyPartImage extends StatelessWidget {
  const ExerciseBodyPartImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 35.0,
      //backgroundImage: image != null ? NetworkImage(image) : null,
      child: Icon(Icons.leaderboard, size: 45.0)
    );
  }
}