part of 'all_trainings_widget_bloc.dart';

class AllTrainingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllTrainings extends AllTrainingsEvent {
  GetAllTrainings({
    required this.userID,
  });
  final String userID;

  @override
  List<Object?> get props => [];
}

class RefreshAllTrainings extends AllTrainingsEvent {
  RefreshAllTrainings({
    required this.userID,
  });
  final String userID;

  @override
  List<Object?> get props => [];
}


class GetTrainingsByCategory extends AllTrainingsEvent {
  GetTrainingsByCategory({
    required this.categoryName,
    required this.userID,
  });
  final String userID;
  final String categoryName;

  @override
  List<Object?> get props => [categoryName];

}

class DeleteTraining extends AllTrainingsEvent {
  DeleteTraining({
    required this.trainingID,
    required this.userID,
  });
  final String trainingID;
  final String userID;

  @override
  List<Object?> get props => [];
}