part of 'category_widget_bloc.dart';

@immutable
abstract class CategoryWidgetState {}

class CategorySelected extends CategoryWidgetState {
  final String idCategory;

  CategorySelected(this.idCategory);
}

class CategoryWidgetInitial extends CategoryWidgetState {}

class CategoryWidgetLoading extends CategoryWidgetState {}

class CategoryExerciseWidgetLoaded extends CategoryWidgetState {
  final List<Exercise> exerciseByCategories;

  CategoryExerciseWidgetLoaded(this.exerciseByCategories);
}

class CategoryWidgetLoaded extends CategoryWidgetState {
  final List<BodyParts> categories;

  CategoryWidgetLoaded(this.categories);
}

class CategoryOperationSuccess extends CategoryWidgetState {
  final String message;

  CategoryOperationSuccess(this.message);
}

class CategoryOperationFailure extends CategoryWidgetState {
  final String message;

  CategoryOperationFailure(this.message);
}