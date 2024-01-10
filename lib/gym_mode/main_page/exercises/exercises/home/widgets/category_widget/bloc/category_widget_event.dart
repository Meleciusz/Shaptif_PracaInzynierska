part of 'category_widget_bloc.dart';

/*
 * Main description:
This file contains every event that bloc can have
 */
class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends CategoryEvent {
  @override
  List<Object?> get props => [];
}

class SelectCategory extends CategoryEvent {
  SelectCategory({
    required this.idSelected,
  });

  final int idSelected;

  @override
  List<Object?> get props => [idSelected];
}