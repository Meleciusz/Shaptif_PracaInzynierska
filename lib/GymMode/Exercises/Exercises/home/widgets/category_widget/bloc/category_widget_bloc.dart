import 'dart:async';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/exercises.dart';
import 'package:body_parts_repository/body_parts_repository.dart';

part 'category_widget_event.dart';
part 'category_widget_state.dart';

class CategoryWidgetBloc extends Bloc<CategoryWidgetEvent, CategoryWidgetState> {
  final FirestoreExerciseService firestoreServiceExercise;
  final FirestoreBodyPartsService firestoreBodyPartsService;

  CategoryWidgetBloc(this.firestoreServiceExercise, this.firestoreBodyPartsService) : super(CategoryWidgetInitial()) {
    on<GetCategories>((event, emit) async {
      try {
        emit(CategoryWidgetLoading());
        final categories = await firestoreBodyPartsService.getBodyParts();
        emit(CategoryWidgetLoaded(categories));
      } catch (e) {
        emit(CategoryOperationFailure("Failed to load body parts"));
      }
    });
  }
}
