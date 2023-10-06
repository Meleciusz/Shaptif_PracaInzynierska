part of 'all_exercises_bloc.dart';

@immutable
abstract class AllExercisesState{}

class AllExercisesInitial extends AllExercisesState {}

class ExercisesLoading extends AllExercisesState {}

class ExercisesLoaded extends AllExercisesState {
  final List<Exercise> exercises;

  ExercisesLoaded(this.exercises);
}

class ExerciseOperationSuccess extends AllExercisesState {
  final String message;

  ExerciseOperationSuccess(this.message);
}

class ExerciseOperationFailure extends AllExercisesState {
  final String message;

  ExerciseOperationFailure(this.message);
}
