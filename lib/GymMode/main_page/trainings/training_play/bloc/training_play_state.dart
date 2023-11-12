part of 'training_play_bloc.dart';

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
  });

  final TrainingPlayStatus status;
  final List<Training>? trainings;

  @override
  List<Object?> get props => [status, trainings];

  TrainingPlayState copyWith({
    TrainingPlayStatus? status,
    List<Training>? trainings,
  }){
    return TrainingPlayState(
      status: status ?? this.status,
      trainings: trainings ?? this.trainings,
    );
  }
}