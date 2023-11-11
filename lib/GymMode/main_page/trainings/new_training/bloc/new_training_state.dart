part of 'new_training_bloc.dart';

enum NewTrainingStatus { initial, loading, success, error }

extension NewTrainingStatusX on NewTrainingStatus {
  bool get isInitial => this == NewTrainingStatus.initial;
  bool get isLoading => this == NewTrainingStatus.loading;
  bool get isSuccess => this == NewTrainingStatus.success;
  bool get isError => this == NewTrainingStatus.error;
}

class NewTrainingState extends Equatable {
  const NewTrainingState({
    this.status = NewTrainingStatus.initial,
    this.exercises,
  });

  final NewTrainingStatus status;
  final List<Exercise>? exercises;

  @override
  List<Object?> get props => [status, exercises];

  NewTrainingState copyWith({
    NewTrainingStatus? status,
    List<Exercise>? exercises,
  }){
    return NewTrainingState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
    );
  }
}