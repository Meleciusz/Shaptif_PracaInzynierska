import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:exercise_repository/exercise_repository.dart';


part 'all_exercises_event.dart';
part 'all_exercises_state.dart';

class AllExercisesBloc extends Bloc<AllExercisesEvent, AllExercisesState> {
  final FirestoreExerciseService firestoreService;

  AllExercisesBloc(this.firestoreService) : super(AllExercisesInitial()){
    on<LoadAllExercises>((event, emit) async{
      try{
        emit(ExercisesLoading());
        final exercises = await firestoreService.getExercises();
        emit(ExercisesLoaded(exercises));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to load exercises"));
      }
    });

    on<LoadVeryfiedExercises>((event, emit) async{
      try{
        emit(ExercisesLoading());
        final exercises = await firestoreService.getVerifiedExercises();
        emit(ExercisesLoaded(exercises));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to load exercises"));
      }
    });

    on<RefreshExercises>((event, emit) async {
      try {
        emit(ExercisesLoading());

        await firestoreService.clearFirestoreCache();

        final exercises = await firestoreService.getExercises();
        emit(ExercisesLoaded(exercises));
      } catch (e) {
        emit(ExerciseOperationFailure("Failed to refresh exercises"));
      }
    });

    on<AddExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await firestoreService.addExercise(event.exercise);
        emit(ExerciseOperationSuccess("Exercise added"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to add exercise"));
      }
    });

    on<UpdateExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await firestoreService.updateExercise(event.exercise);
        emit(ExerciseOperationSuccess("Exercise updated"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to update exercise"));
      }
    });

    on<DeleteExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await firestoreService.deleteExercise(event.id);
        emit(ExerciseOperationSuccess("Exercise deleted"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to delete exercise"));
      }
    });
  }
}
