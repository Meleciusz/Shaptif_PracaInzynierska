part of 'all_exercises_bloc.dart';

@immutable
abstract class AllExercisesEvent{}

class LoadAllExercises extends AllExercisesEvent {}

class RefreshExercises extends AllExercisesEvent {}

class AddExercise extends AllExercisesEvent {
  final Exercise exercise;

  AddExercise(this.exercise);
}

class UpdateExercise extends AllExercisesEvent {
  final Exercise exercise;

  UpdateExercise(this.exercise);
}

class DeleteExercise extends AllExercisesEvent {
  final String id;

  DeleteExercise(this.id);
}