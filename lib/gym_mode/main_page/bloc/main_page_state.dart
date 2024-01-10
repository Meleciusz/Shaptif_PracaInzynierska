part of 'main_page_bloc.dart';

/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */

enum MainPageStatus { exercisesStatus, trainingsStatus }

extension MainPageStatusX on MainPageStatus {
  bool get isExercisesStatus => this == MainPageStatus.exercisesStatus;
  bool get isTrainingsStatus => this == MainPageStatus.trainingsStatus;
}

final class MainPageState extends Equatable {
  const MainPageState({
    this.status = MainPageStatus.trainingsStatus,
  });

  final MainPageStatus status;

  @override
  List<Object?> get props => [status];

  MainPageState copyWith({
    MainPageStatus? status,
  }){
    return MainPageState(
      status: status ?? this.status,
    );
  }
}




