import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:history_repository/history_repository.dart';
import 'package:meta/meta.dart';
import 'package:training_repository/training_repository.dart';

part 'training_play_event.dart';
part 'training_play_state.dart';

class TrainingPlayBloc extends Bloc<TrainingPlayEvent, TrainingPlayState> {
  TrainingPlayBloc({
    required this.trainingRepository, required this.exerciseRepository, required this.historyRepository
  }) : super(const TrainingPlayState()){
    on<UpdateTrainingStatus>(_mapUpdateTrainingStatusEvent);
    on<GetTrainingsAndExercises>(_mapGetTrainingsEvent);
    on<RefreshPlayTrainings>(_mapRefreshPlayTrainingsEvent);
    on<SaveAsHistoricalTraining>(_mapSaveAsHistoricalTrainingEvent);
  }

  final FirestoreTrainingService trainingRepository;
  final FirestoreExerciseService exerciseRepository;
  final FirestoreHistoryService historyRepository;

  void _mapGetTrainingsEvent(GetTrainingsAndExercises event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      final trainings = await trainingRepository.getAllTrainings();
      final exercises = await exerciseRepository.getExercises();
      emit(state.copyWith(status: TrainingPlayStatus.success, trainings: trainings, exercises: exercises));
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }

  void _mapUpdateTrainingStatusEvent(UpdateTrainingStatus event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      await trainingRepository.updateTraining(event.training);
      emit(state.copyWith(status: TrainingPlayStatus.success));

      add(RefreshPlayTrainings());
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }

  void _mapRefreshPlayTrainingsEvent(RefreshPlayTrainings event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      await trainingRepository.clearFirestoreCache();
      final trainings = await trainingRepository.getAllTrainings();
      emit(state.copyWith(status: TrainingPlayStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }

  void _mapSaveAsHistoricalTrainingEvent(SaveAsHistoricalTraining event, Emitter<TrainingPlayState> emit) async {
    try {
      emit(state.copyWith(status: TrainingPlayStatus.loading));
      await historyRepository.addHistoricalTraining(event.history);
      emit(state.copyWith(status: TrainingPlayStatus.success));

      add(RefreshPlayTrainings());
    } catch (e) {
      emit(state.copyWith(status: TrainingPlayStatus.error));
    }
  }
}
