import 'dart:developer';

import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key, required this.exercises});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    exercises.length > 0 ?
    log(exercises.first.name) : log("brak");
    return Container();
  }
}