import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:exercise_repository/exercise_repository.dart';


part 'all_exercises_event.dart';
part 'all_exercises_state.dart';

class AllExercisesBloc extends Bloc<AllExercisesEvent, AllExercisesState> {
  final FirestoreService _firestoreService;

  AllExercisesBloc(this._firestoreService) : super(AllExercisesInitial()){
    on<LoadAllExercises>((event, emit) async{
      try{
        emit(ExercisesLoading());
        final exercises = await _firestoreService.getExercises().first;
        emit(ExercisesLoaded(exercises));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to load exercises"));
      }
    });

    on<AddExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await _firestoreService.addExercise(event.exercise);
        emit(ExerciseOperationSuccess("Exercise added"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to add exercise"));
      }
    });

    on<UpdateExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await _firestoreService.updateExercise(event.exercise);
        emit(ExerciseOperationSuccess("Exercise updated"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to update exercise"));
      }
    });

    on<DeleteExercise>((event, emit) async {
      try{
        emit(ExercisesLoading());
        await _firestoreService.deleteExercise(event.id);
        emit(ExerciseOperationSuccess("Exercise deleted"));
      } catch(e){
        emit(ExerciseOperationFailure("Failed to delete exercise"));
      }
    });
  }
}
