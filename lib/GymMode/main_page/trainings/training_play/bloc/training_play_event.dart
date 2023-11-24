part of 'training_play_bloc.dart';

class TrainingPlayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTrainingStatus extends TrainingPlayEvent {
  UpdateTrainingStatus({
    required this.training,
    required this.userID
  });
  final Training training;
  final String userID;

  @override
  List<Object?> get props => [];
}

class UpdateTrainingStatusWithoutInternet extends TrainingPlayEvent {
  UpdateTrainingStatusWithoutInternet({
    required this.training,
    required this.userID
  });
  final Training training;
  final String userID;

  @override
  List<Object?> get props => [];
}

class GetTrainingsAndExercises extends TrainingPlayEvent {
  GetTrainingsAndExercises({
    required this.userID,
  });
  final String userID;


  @override
  List<Object?> get props => [];
}

class RefreshPlayTrainings extends TrainingPlayEvent {
  RefreshPlayTrainings({
    required this.userID,
  });
  final String userID;

  @override
  List<Object?> get props => [];
}

class SaveAsHistoricalTraining extends TrainingPlayEvent {
 SaveAsHistoricalTraining({
    required this.history,
   required this.userID
});
  final History history;
  final String userID;

  @override
  List<Object?> get props => [];
}

class SaveAsHistoricalTrainingWithoutInternet extends TrainingPlayEvent {
  SaveAsHistoricalTrainingWithoutInternet({
    required this.history,
   required this.userID
});
  final History history;
  final String userID;

  @override
  List<Object?> get props => [];
}
