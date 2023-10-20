import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:meta/meta.dart';

part 'exercises_by_category_event.dart';
part 'exercises_by_category_state.dart';

class ExercisesByCategoryBloc extends Bloc<ExercisesByCategoryEvent, ExercisesByCategoryState> {
  final FirestoreExerciseService firestoreService;
  final FirestoreBodyPartsService firestoreBodyPartsService;

  ExercisesByCategoryBloc(this.firestoreService, this.firestoreBodyPartsService) : super(ExercisesByCategoryInitial()) {
    on<GetExercisesByCategory>((event, emit) async{
      try{
        emit(ExercisesByCategoryLoading());
        final exercisesByCategory = await firestoreService.getExercisesByCategory(event.selected);
        emit(ExercisesByCategoryLoaded(exercisesByCategory));
      }catch(e){
        emit(ExercisesByCategoryOperationFailure("Failed to load exercises by category"));
      }
    });
  }

}
