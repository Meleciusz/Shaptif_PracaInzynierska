part of 'exercises_by_category_bloc.dart';

/*
 * Main description:
This file contains every event that bloc can have
 */
class ExercisesByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetExercisesByCategory extends ExercisesByCategoryEvent {
  GetExercisesByCategory({
     required this.idSelected,
     required this.categoryName,
  });
  final int idSelected;
  final String categoryName;

  @override
  List<Object?> get props => [idSelected, categoryName];
}

class RefreshExercisesByCategory extends ExercisesByCategoryEvent {
  @override
  List<Object?> get props => [];
}