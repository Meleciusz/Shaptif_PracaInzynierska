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

class GetTrainingsByCategory_ extends AllTrainingsEvent {
  GetTrainingsByCategory_({
    required this.categoryName,
  });

  final String categoryName;

  @override
  List<Object?> get props => [categoryName];

}

class DeleteTraining extends AllTrainingsEvent {
  DeleteTraining({
    required this.trainingID,
  });
  final String trainingID;

  @override
  List<Object?> get props => [];
}