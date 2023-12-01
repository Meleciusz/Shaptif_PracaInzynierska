import 'package:flutter/material.dart';
import 'package:shaptifii/GymMode/main_page/main_page.dart';
import '../exercises/exercises/home/pages/home_page.dart';
import '../trainings/trainings/home/pages/home_page.dart';

/*
 *Main description:
This file contains the routes for the main page.
 */
List<Page<dynamic>> onGenerateExerciseAndTrainingPages(
  MainPageStatus state,
  List<Page<dynamic>> pages,
){
  switch(state){
    case MainPageStatus.exercisesStatus:
      return[HomePageGym.page()];
    case MainPageStatus.trainingsStatus:
      return [HomePageTrainings.page()];
  }
}