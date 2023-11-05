part of 'trainings_by_category_bloc.dart';

enum TrainingsByCategoryStatus { initial, loading, success, error }

extension TrainingsByCategoryStatusX on TrainingsByCategoryStatus {
  bool get isInitial => this == TrainingsByCategoryStatus.initial;
  bool get isLoading => this == TrainingsByCategoryStatus.loading;
  bool get isSuccess => this == TrainingsByCategoryStatus.success;
  bool get isError => this == TrainingsByCategoryStatus.error;
}

class TrainingsByCategoryState extends Equatable {
  const TrainingsByCategoryState({
    this.status = TrainingsByCategoryStatus.initial,
    List<Training>? trainings,
    String? categoryName,
  }): trainings = trainings ?? const [],
        categoryName = categoryName ?? '';

  final List<Training> trainings;
  final String categoryName;
  final TrainingsByCategoryStatus status;

  @override
  List<Object?> get props => [trainings, categoryName, status];

  TrainingsByCategoryState copyWith({
    TrainingsByCategoryStatus? status,
    List<Training>? trainings,
    String? categoryName,
  }) {
    return TrainingsByCategoryState(
      status: status ?? this.status,
      trainings: trainings ?? this.trainings,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}