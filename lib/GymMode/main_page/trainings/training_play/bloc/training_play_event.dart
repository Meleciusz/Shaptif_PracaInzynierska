part of 'training_play_bloc.dart';

class TrainingPlayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTrainingStatus extends TrainingPlayEvent {
  UpdateTrainingStatus({
    required this.training,
  });
  final Training training;

  @override
  List<Object?> get props => [];
}

class GetTrainingsAndExercises extends TrainingPlayEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPlayTrainings extends TrainingPlayEvent {
  @override
  List<Object?> get props => [];
}

class SaveAsHistoricalTraining extends TrainingPlayEvent {
 SaveAsHistoricalTraining({
    required this.history
});
  final History history;

  @override
  List<Object?> get props => [];
}
