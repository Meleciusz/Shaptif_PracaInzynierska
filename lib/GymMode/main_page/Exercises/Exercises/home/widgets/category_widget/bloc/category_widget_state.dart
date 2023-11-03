part of 'category_widget_bloc.dart';

enum CategoryStatus { initial, loading, success, error, selected }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isSelected => this == CategoryStatus.selected;
}

final class CategoryState extends Equatable {
  const CategoryState({
    this.status = CategoryStatus.initial,
    List<BodyParts>? categories,
    this.idSelected = 0,
  }): categories = categories ?? const [];

  final List<BodyParts> categories;
  final int idSelected;
  final CategoryStatus status;

  @override
  List<Object?> get props => [categories, idSelected, status];

  CategoryState copyWith({
    CategoryStatus? status,
    List<BodyParts>? categories,
    int? idSelected,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      idSelected: idSelected ?? this.idSelected,
    );
  }
}