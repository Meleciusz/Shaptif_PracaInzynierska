part of 'new_training_bloc.dart';

/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */
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
    this.bodyParts,
  });

  final NewTrainingStatus status;
  final List<Exercise>? exercises;
  final List<BodyParts>? bodyParts;

  @override
  List<Object?> get props => [status, exercises, bodyParts];

  NewTrainingState copyWith({
    NewTrainingStatus? status,
    List<Exercise>? exercises,
    List<BodyParts>? bodyParts,
  }){
    return NewTrainingState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      bodyParts: bodyParts ?? this.bodyParts,
    );
  }
}