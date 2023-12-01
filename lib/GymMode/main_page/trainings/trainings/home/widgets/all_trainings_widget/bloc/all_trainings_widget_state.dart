part of 'all_trainings_widget_bloc.dart';

/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */
enum AllTrainingsStatus { initial, loading, success, error }

extension AllTrainingsStatusX on AllTrainingsStatus {
  bool get isInitial => this == AllTrainingsStatus.initial;
  bool get isLoading => this == AllTrainingsStatus.loading;
  bool get isSuccess => this == AllTrainingsStatus.success;
  bool get isError => this == AllTrainingsStatus.error;
}

class AllTrainingsState extends Equatable {
  const AllTrainingsState({
    this.status = AllTrainingsStatus.initial,
    this.trainings,
  });

  final List<Training>? trainings;
  final AllTrainingsStatus status;

  @override
  List<Object?> get props => [trainings, status];

  AllTrainingsState copyWith({
    AllTrainingsStatus? status,
    List<Training>? trainings,
  }){
    return AllTrainingsState(
      status: status ?? this.status,
      trainings: trainings ?? this.trainings,
    );
  }
}