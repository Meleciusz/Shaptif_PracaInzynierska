import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:exercise_repository/exercise_repository.dart';


part 'all_exercises_event.dart';
part 'all_exercises_state.dart';

class AllExercisesBloc extends Bloc<AllExercisesEvent, AllExercisesState> {
  AllExercisesBloc({
    required this.firestoreService,
  }) : super(const AllExercisesState()) {
    on<GetExercises>(_mapGetExercisesEvent);
    on<RefreshExercises>(_mapRefreshExercisesEvent);
    on<AddExercise>(_mapAddExerciseEvent);
    on<DeleteExercise>(_mapDeleteExerciseEvent);
  }

  final FirestoreExerciseService firestoreService;

  void _mapGetExercisesEvent(GetExercises event, Emitter<AllExercisesState> emit) async {
    try {
      emit(state.copyWith(status: AllExercisesStatus.loading));
      final exercises = await firestoreService.getExercises();
      emit(state.copyWith(status: AllExercisesStatus.success, exercises: exercises));

      add(RefreshExercises());
    } catch (e) {
      emit(state.copyWith(status: AllExercisesStatus.error));
    }
  }

  void _mapRefreshExercisesEvent(RefreshExercises event, Emitter<AllExercisesState> emit) async {
    try {
      emit(state.copyWith(status: AllExercisesStatus.loading));
      await firestoreService.clearFirestoreCache();
      final exercises = await firestoreService.getExercises();
      emit(state.copyWith(status: AllExercisesStatus.success, exercises: exercises));
    } catch (e) {
      emit(state.copyWith(status: AllExercisesStatus.error));
    }
  }

  void _mapAddExerciseEvent(AddExercise event, Emitter<AllExercisesState> emit) async {
    try {
      emit(state.copyWith(status: AllExercisesStatus.loading));
      await firestoreService.addExercise(event.exercise);
      emit(state.copyWith(status: AllExercisesStatus.success));

      add(RefreshExercises());
    } catch (e) {
      emit(state.copyWith(status: AllExercisesStatus.error));
    }
  }

  void _mapDeleteExerciseEvent(DeleteExercise event, Emitter<AllExercisesState> emit) async {
    try {
      emit(state.copyWith(status: AllExercisesStatus.loading));
      await firestoreService.deleteExercise(event.exerciseID);
      emit(state.copyWith(status: AllExercisesStatus.success));

      add(RefreshExercises());
    } catch (e) {
      emit(state.copyWith(status: AllExercisesStatus.error));
    }
  }
}
