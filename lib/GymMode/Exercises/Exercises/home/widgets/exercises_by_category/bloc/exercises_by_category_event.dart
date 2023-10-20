part of 'exercises_by_category_bloc.dart';

@immutable
abstract class ExercisesByCategoryEvent {}

class GetExercisesByCategory extends ExercisesByCategoryEvent {
  final String selected;

  GetExercisesByCategory(this.selected);
}