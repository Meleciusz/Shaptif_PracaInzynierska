import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:training_repository/training_repository.dart';

part 'trainings_by_category_event.dart';
part 'trainings_by_category_state.dart';

class TrainingsByCategoryBloc extends Bloc<TrainingsByCategoryEvent, TrainingsByCategoryState> {
  TrainingsByCategoryBloc({
    required this.firestoreService,
  }) : super(TrainingsByCategoryState()) {
    on<GetTrainingsByCategory>(_mapGetTrainingsByCategoryEvent);
    on<RefreshTrainingsByCategory>(_mapRefreshTrainingsByCategoryEvent);
  }
  final FirestoreTrainingService firestoreService;

  void _mapGetTrainingsByCategoryEvent(GetTrainingsByCategory event, Emitter<TrainingsByCategoryState> emit) async {
    try {
      emit(state.copyWith(status: TrainingsByCategoryStatus.loading));
      final trainingsByCategory = await firestoreService.getTrainingsByCategory(event.categoryName);
      emit(state.copyWith(status: TrainingsByCategoryStatus.success, trainings: trainingsByCategory, categoryName: event.categoryName));
    } catch (e) {
      emit(state.copyWith(status: TrainingsByCategoryStatus.error));
    }
  }

  void _mapRefreshTrainingsByCategoryEvent(RefreshTrainingsByCategory event, Emitter<TrainingsByCategoryState> emit) async {
    try {
      emit(state.copyWith(status: TrainingsByCategoryStatus.loading));
      await firestoreService.clearFirestoreCache();
      final trainingsByCategory = await firestoreService.getTrainingsByCategory(state.categoryName);
      emit(state.copyWith(status: TrainingsByCategoryStatus.success, trainings: trainingsByCategory, categoryName: state.categoryName));
    } catch (e) {
      emit(state.copyWith(status: TrainingsByCategoryStatus.error));
    }
  }
}
