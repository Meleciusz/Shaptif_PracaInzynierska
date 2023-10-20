part of 'exercises_by_category_bloc.dart';

@immutable
abstract class ExercisesByCategoryState {}

class ExercisesByCategoryInitial extends ExercisesByCategoryState {}

class ExercisesByCategoryLoading extends ExercisesByCategoryState {}

class ExercisesByCategoryLoaded extends ExercisesByCategoryState {
  final List<Exercise> exercises;

  ExercisesByCategoryLoaded(this.exercises);
}

class ExercisesByCategoryOperationSuccess extends ExercisesByCategoryState {
  final String message;

  ExercisesByCategoryOperationSuccess(this.message);
}

class ExercisesByCategoryOperationFailure extends ExercisesByCategoryState {
  final String message;

  ExercisesByCategoryOperationFailure(this.message);
}