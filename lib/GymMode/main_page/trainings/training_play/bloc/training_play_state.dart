part of 'training_play_bloc.dart';

/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */
enum TrainingPlayStatus { initial, loading, success, error }

extension TrainingPlayStatusX on TrainingPlayStatus {
  bool get isInitial => this == TrainingPlayStatus.initial;
  bool get isLoading => this == TrainingPlayStatus.loading;
  bool get isSuccess => this == TrainingPlayStatus.success;
  bool get isError => this == TrainingPlayStatus.error;
}

class TrainingPlayState extends Equatable {
  const TrainingPlayState({
    this.status = TrainingPlayStatus.initial,
    this.trainings,
    this.exercises,
  });

  final TrainingPlayStatus status;
  final List<Training>? trainings;
  final List<Exercise>? exercises;

  @override
  List<Object?> get props => [status, trainings, exercises];

  TrainingPlayState copyWith({
    TrainingPlayStatus? status,
    List<Training>? trainings,
    List<Exercise>? exercises
  }){
    return TrainingPlayState(
      status: status ?? this.status,
      trainings: trainings ?? this.trainings,
      exercises: exercises ?? this.exercises
    );
  }
}