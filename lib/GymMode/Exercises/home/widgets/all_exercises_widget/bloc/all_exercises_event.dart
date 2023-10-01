part of 'all_exercises_bloc.dart';

@immutable
abstract class AllExercisesEvent {}

class LoadAllExercises extends AllExercisesEvent {}

class AddExercise extends AllExercisesEvent {
  final Exercise exercise;

  AddExercise(this.exercise);
}
