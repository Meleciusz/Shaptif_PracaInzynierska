import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_repository/training_repository.dart';

part 'all_trainings_widget_event.dart';
part 'all_trainings_widget_state.dart';

class AllTrainingsBloc extends Bloc<AllTrainingsEvent, AllTrainingsState> {
  AllTrainingsBloc({
    required this.firestoreService,
  }) : super(const AllTrainingsState()) {
    on<GetAllTrainings>(_mapGetTrainingsEvent);
    on<RefreshAllTrainings>(_mapRefreshTrainingsEvent);
    on<DeleteTraining>(_mapDeleteTrainingEvent);
    on<GetTrainingsByCategory>(_mapGetTrainingsByCategoryEvent);
  }

  final FirestoreTrainingService firestoreService;

  void _mapGetTrainingsByCategoryEvent(GetTrainingsByCategory event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      final trainings = await firestoreService.getTrainingsByCategory(event.categoryName);
      emit(state.copyWith(status: AllTrainingsStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }

  void _mapGetTrainingsEvent(GetAllTrainings event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      final trainings = await firestoreService.getAllTrainings();
      emit(state.copyWith(status: AllTrainingsStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }

  void _mapRefreshTrainingsEvent(RefreshAllTrainings event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      await firestoreService.clearFirestoreCache();
      final trainings = await firestoreService.getAllTrainings();
      emit(state.copyWith(status: AllTrainingsStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }


  void _mapDeleteTrainingEvent(DeleteTraining event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      await firestoreService.deleteTraining(event.trainingID);
      emit(state.copyWith(status: AllTrainingsStatus.success));

      add(RefreshAllTrainings());
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }
}
