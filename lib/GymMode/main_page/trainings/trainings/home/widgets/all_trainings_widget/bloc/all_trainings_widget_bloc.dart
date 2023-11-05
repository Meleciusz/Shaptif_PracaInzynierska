import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_repository/training_repository.dart';

part 'all_trainings_widget_event.dart';
part 'all_trainings_widget_state.dart';

class AllTrainingsBloc extends Bloc<AllTrainingsEvent, AllTrainingsState> {
  AllTrainingsBloc({
    required this.firestoreService,
  }) : super(const AllTrainingsState()) {
    on<GetTrainings>(_mapGetTrainingsEvent);
    on<RefreshTrainings>(_mapRefreshTrainingsEvent);
    on<AddTraining>(_mapAddTrainingEvent);
    on<DeleteTraining>(_mapDeleteTrainingEvent);
  }

  final FirestoreTrainingService firestoreService;

  void _mapGetTrainingsEvent(GetTrainings event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      final trainings = await firestoreService.getTrainings();
      emit(state.copyWith(status: AllTrainingsStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }

  void _mapRefreshTrainingsEvent(RefreshTrainings event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      await firestoreService.clearFirestoreCache();
      final trainings = await firestoreService.getTrainings();
      emit(state.copyWith(status: AllTrainingsStatus.success, trainings: trainings));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }

  void _mapAddTrainingEvent(AddTraining event, Emitter<AllTrainingsState> emit) async {
    // try {
    //   emit(state.copyWith(status: AllTrainingsStatus.loading));
    //   await firestoreService.addTraining(event.training);
    //   emit(state.copyWith(status: AllTrainingsStatus.success));
    // } catch (e) {
    //   emit(state.copyWith(status: AllTrainingsStatus.error));
    // }
  }

  void _mapDeleteTrainingEvent(DeleteTraining event, Emitter<AllTrainingsState> emit) async {
    try {
      emit(state.copyWith(status: AllTrainingsStatus.loading));
      await firestoreService.deleteTraining(event.trainingID);
      emit(state.copyWith(status: AllTrainingsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AllTrainingsStatus.error));
    }
  }
}
