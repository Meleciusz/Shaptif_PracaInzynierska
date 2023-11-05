part of 'trainings_by_category_bloc.dart';

class TrainingsByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTrainingsByCategory extends TrainingsByCategoryEvent {
  GetTrainingsByCategory({
    required this.idSelected,
    required this.categoryName,
  });
  final int idSelected;
  final String categoryName;

  @override
  List<Object?> get props => [idSelected, categoryName];
}

class RefreshTrainingsByCategory extends TrainingsByCategoryEvent {
  @override
  List<Object?> get props => [];
}