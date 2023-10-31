import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:history_repository/history_repository.dart';

part 'show_history_widget_event.dart';
part 'show_history_widget_state.dart';

class ShowHistoryWidgetBloc extends Bloc<ShowHistoryWidgetEvent, ShowHistoryWidgetState> {
  ShowHistoryWidgetBloc({
    required this.historyRepository,
  }) : super(const ShowHistoryWidgetState()) {
    on<GetHistoryEvent>(_onGetHistory);
  }

  final user = FirebaseAuth.instance.currentUser;
  final FirestoreHistoryService historyRepository;

  void _onGetHistory(GetHistoryEvent event, Emitter<ShowHistoryWidgetState> emit) async{
    try{
      emit(state.copyWith(status: ShowHistoryWidgetStatus.loading));
      final history = await historyRepository.getHistoryForUser(user!.uid);
      emit(state.copyWith(status: ShowHistoryWidgetStatus.success, history: history));
    }catch(e){
      emit(state.copyWith(status: ShowHistoryWidgetStatus.error));
    }
  }
}
