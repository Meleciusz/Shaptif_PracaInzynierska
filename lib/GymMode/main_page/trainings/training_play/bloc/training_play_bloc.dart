import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:meta/meta.dart';
import 'package:training_repository/training_repository.dart';

part 'training_play_event.dart';
part 'training_play_state.dart';

class TrainingPlayBloc extends Bloc<TrainingPlayEvent, TrainingPlayState> {
  TrainingPlayBloc({
    required this.trainingRepository, required this.exerciseRepository,
  }) : super(const TrainingPlayState()){
    on<UpdateTrainingStatus>(_mapUpdateTrainingStatusEvent);
    on<GetTrainings>(_mapGetTrainingsEvent);
  }

  final FirestoreTrainingService trainingRepository;
  final FirestoreExerciseService exerciseRepository;

  void _mapGetTrainingsEvent(GetTrainings event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      final trainings = await trainingRepository.getTrainings();
      emit(state.copyWith(status: TrainingPlayStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }

  void _mapUpdateTrainingStatusEvent(UpdateTrainingStatus event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      await trainingRepository.updateTraining(event.training);
      emit(state.copyWith(status: TrainingPlayStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }
}
