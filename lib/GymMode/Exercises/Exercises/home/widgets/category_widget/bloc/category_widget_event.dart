part of 'category_widget_bloc.dart';

@immutable
abstract class CategoryWidgetEvent {}

class GetCategories extends CategoryWidgetEvent {
}

class GetCategory extends CategoryWidgetEvent {
  final int idCategory;

  GetCategory(this.idCategory);
}