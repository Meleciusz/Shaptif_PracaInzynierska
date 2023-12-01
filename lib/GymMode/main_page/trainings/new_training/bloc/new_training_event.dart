part of 'new_training_bloc.dart';

/*
 * Main description:
This file contains every event that bloc can have
 */
class NewTrainingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddNewTraining extends NewTrainingEvent {
  AddNewTraining({
    required this.training,
  });
  final Training training;

  @override
  List<Object?> get props => [];
}

class GetExercises extends NewTrainingEvent {
  @override
  List<Object?> get props => [];
}