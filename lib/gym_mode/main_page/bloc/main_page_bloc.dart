import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

/*
 * Main description:
This file describes every event that bloc can have and connects those events with the states and repositories
 */
class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const MainPageState()) {
    on<ChangeCategory>(_mapChangeCategoryEvent);
  }

  void _mapChangeCategoryEvent(ChangeCategory event, Emitter<MainPageState> emit) {
    state.status.isExercisesStatus ?
        emit(state.copyWith(status: MainPageStatus.trainingsStatus)) :
        emit(state.copyWith(status: MainPageStatus.exercisesStatus));
  }
}




