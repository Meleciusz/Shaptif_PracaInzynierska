part of 'show_history_widget_bloc.dart';

/*
* Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */

enum ShowHistoryWidgetStatus { initial, success, loading, error }

extension ShowHistoryWidgetStatusX on ShowHistoryWidgetStatus {
  bool get isInitial => this == ShowHistoryWidgetStatus.initial;
  bool get isSuccess => this == ShowHistoryWidgetStatus.success;
  bool get isLoading => this == ShowHistoryWidgetStatus.loading;
  bool get isError => this == ShowHistoryWidgetStatus.error;
}

class ShowHistoryWidgetState extends Equatable {
  const ShowHistoryWidgetState({
    this.status = ShowHistoryWidgetStatus.initial,
    this.history,
  });

  final List<History>? history;
  final ShowHistoryWidgetStatus status;

  @override
  List<Object?> get props => [history, status];

  ShowHistoryWidgetState copyWith({
    ShowHistoryWidgetStatus? status,
    List<History>? history,
  }){
    return ShowHistoryWidgetState(
      status: status ?? this.status,
      history: history ?? this.history,
      );
  }
}