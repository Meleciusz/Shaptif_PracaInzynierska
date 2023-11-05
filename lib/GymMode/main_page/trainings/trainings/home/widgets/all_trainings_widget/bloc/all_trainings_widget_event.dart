part of 'all_trainings_widget_bloc.dart';

class AllTrainingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrainings extends AllTrainingsEvent {
  @override
  List<Object?> get props => [];
}

class RefreshTrainings extends AllTrainingsEvent {
  @override
  List<Object?> get props => [];
}

class AddTraining extends AllTrainingsEvent {
  AddTraining({
    required this.training,
  });
  final Training training;

  @override
  List<Object?> get props => [];
}

class DeleteTraining extends AllTrainingsEvent {
  DeleteTraining({
    required this.trainingID,
  });
  final String trainingID;

  @override
  List<Object?> get props => [];
}