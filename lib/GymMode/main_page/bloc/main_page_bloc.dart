import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

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
