part of 'exercises_by_category_bloc.dart';

/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */
enum ExercisesByCategoryStatus { initial, loading, success, error }

extension AllExercisesStatusX on ExercisesByCategoryStatus {
  bool get isInitial => this == ExercisesByCategoryStatus.initial;
  bool get isLoading => this == ExercisesByCategoryStatus.loading;
  bool get isSuccess => this == ExercisesByCategoryStatus.success;
  bool get isError => this == ExercisesByCategoryStatus.error;
}

class ExercisesByCategoryState extends Equatable {
  const ExercisesByCategoryState({
    this.status = ExercisesByCategoryStatus.initial,
    List<Exercise>? exercises,
    String? categoryName,
  }) : exercises = exercises ?? const [],
        categoryName = categoryName ?? '';

  final List<Exercise> exercises;
  final String categoryName;
  final ExercisesByCategoryStatus status;

  @override
  List<Object?> get props => [exercises, categoryName, status];

  ExercisesByCategoryState copyWith({
    ExercisesByCategoryStatus? status,
    List<Exercise>? exercises,
    String? categoryName,
  }) {
    return ExercisesByCategoryState(
      status: status ?? this.status,
      exercises: exercises,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}