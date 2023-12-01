part of 'all_exercises_bloc.dart';
/*
 * Main description:
This file contains every event that bloc can have
 */
class AllExercisesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetExercises extends AllExercisesEvent {
  @override
  List<Object?> get props => [];
}

class RefreshExercises extends AllExercisesEvent {
  @override
  List<Object?> get props => [];
}

class AddExercise extends AllExercisesEvent {
  AddExercise({
    required this.exercise,
  });
  final Exercise exercise;

  @override
  List<Object?> get props => [];
}

class DeleteExercise extends AllExercisesEvent {
  DeleteExercise({
    required this.exerciseID,
  });
  final String exerciseID;

  @override
  List<Object?> get props => [];
}
