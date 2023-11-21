part of 'all_trainings_widget_bloc.dart';

class AllTrainingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllTrainings extends AllTrainingsEvent {
  @override
  List<Object?> get props => [];
}

class RefreshAllTrainings extends AllTrainingsEvent {
  @override
  List<Object?> get props => [];
}


class GetTrainingsByCategory extends AllTrainingsEvent {
  GetTrainingsByCategory({
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