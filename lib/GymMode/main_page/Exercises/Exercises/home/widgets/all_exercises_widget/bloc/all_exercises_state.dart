part of 'all_exercises_bloc.dart';

enum AllExercisesStatus { initial, loading, success, error }

extension AllExercisesStatusX on AllExercisesStatus {
  bool get isInitial => this == AllExercisesStatus.initial;
  bool get isLoading => this == AllExercisesStatus.loading;
  bool get isSuccess => this == AllExercisesStatus.success;
  bool get isError => this == AllExercisesStatus.error;
}

class AllExercisesState extends Equatable {
  const AllExercisesState({
    this.status = AllExercisesStatus.initial,
    this.exercises,
  });

  final List<Exercise>? exercises;
  final AllExercisesStatus status;

  @override
  List<Object?> get props => [exercises, status];

  AllExercisesState copyWith({
    AllExercisesStatus? status,
    List<Exercise>? exercises,
  }){
    return AllExercisesState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
    );
  }
}