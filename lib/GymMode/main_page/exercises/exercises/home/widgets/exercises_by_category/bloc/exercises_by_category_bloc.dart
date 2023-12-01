import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise_repository/exercise_repository.dart';

part 'exercises_by_category_event.dart';
part 'exercises_by_category_state.dart';

/*
 * Main description:
This file describes every event that bloc can have and connects those events with the states and repositories
 */
class ExercisesByCategoryBloc extends Bloc<ExercisesByCategoryEvent, ExercisesByCategoryState> {
  ExercisesByCategoryBloc({
    required this.firestoreService,
  }) : super(const ExercisesByCategoryState()) {
    on<GetExercisesByCategory>(_mapGetExercisesByCategoryEvent);
    on<RefreshExercisesByCategory>(_mapRefreshExercisesByCategoryEvent);
  }
  final FirestoreExerciseService firestoreService;

  void _mapGetExercisesByCategoryEvent(GetExercisesByCategory event, Emitter<ExercisesByCategoryState> emit) async {
    try {
      emit(state.copyWith(status: ExercisesByCategoryStatus.loading));
      final exercisesByCategory = await firestoreService.getExercisesByCategory(event.categoryName);
      emit(state.copyWith(status: ExercisesByCategoryStatus.success, exercises: exercisesByCategory, categoryName: event.categoryName));

      add(RefreshExercisesByCategory());
    } catch (e) {
      emit(state.copyWith(status: ExercisesByCategoryStatus.error));
    }
  }

  void _mapRefreshExercisesByCategoryEvent(RefreshExercisesByCategory event, Emitter<ExercisesByCategoryState> emit) async {
    try {
      emit(state.copyWith(status: ExercisesByCategoryStatus.loading));
      await firestoreService.clearFirestoreCache();
      final exercisesByCategory = await firestoreService.getExercisesByCategory(state.categoryName);
      emit(state.copyWith(status: ExercisesByCategoryStatus.success, exercises: exercisesByCategory, categoryName: state.categoryName));
    } catch (e) {
      emit(state.copyWith(status: ExercisesByCategoryStatus.error));
    }
  }
}
