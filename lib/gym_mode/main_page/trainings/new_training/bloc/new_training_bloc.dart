import 'package:bloc/bloc.dart';
import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:training_repository/training_repository.dart';

part 'new_training_event.dart';
part 'new_training_state.dart';

/*
 * Main description:
This file describes every event that bloc can have and connects those events with the states and repositories
 */
class NewTrainingBloc extends Bloc<NewTrainingEvent, NewTrainingState> {
  NewTrainingBloc({
    required this.trainingRepository, required this.exerciseRepository, required this.bodyPartsService
  }) : super(const NewTrainingState()){
    on<AddNewTraining>(_mapAddTrainingEvent);
    on<GetExercises>(_mapGetExercisesEvent);
    on<GetBodyParts>(_mapGetBodyPartsEvent);
  }

  final FirestoreTrainingService trainingRepository;
  final FirestoreExerciseService exerciseRepository;
  final FirestoreBodyPartsService bodyPartsService;

  void _mapGetExercisesEvent(GetExercises event, Emitter<NewTrainingState> emit) async {
    try {
      emit(state.copyWith(status: NewTrainingStatus.loading));
      final exercises = await exerciseRepository.getExercises();
      emit(state.copyWith(status: NewTrainingStatus.success, exercises: exercises));
    } catch (e) {
      emit(state.copyWith(status: NewTrainingStatus.error));
    }
  }

  void _mapAddTrainingEvent(AddNewTraining event, Emitter<NewTrainingState> emit) async {
    try {
      emit(state.copyWith(status: NewTrainingStatus.loading));
      await trainingRepository.addTraining(event.training);
      emit(state.copyWith(status: NewTrainingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NewTrainingStatus.error));
    }
  }

  void _mapGetBodyPartsEvent(GetBodyParts event, Emitter<NewTrainingState> emit) async {
    try {
      emit(state.copyWith(status: NewTrainingStatus.loading));
      final bodyParts = await bodyPartsService.getBodyParts();
      emit(state.copyWith(status: NewTrainingStatus.success, bodyParts: bodyParts));
    } catch (e) {
      emit(state.copyWith(status: NewTrainingStatus.error));
    }
  }
}
