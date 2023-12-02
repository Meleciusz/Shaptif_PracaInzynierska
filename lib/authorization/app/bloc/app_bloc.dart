import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authorization_repository/authorization_repository.dart';


part 'app_event.dart';
part 'app_state.dart';

/*
 * Main description:
This file describes every event that bloc can have and connects those events with the states and repositories
 */
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthorizationRepository authorizationRepository}) : _authorizationRepository = authorizationRepository,
  super(
        authorizationRepository.currentUser.isEmpty
            ? AppState.authenticated(authorizationRepository.currentUser)
            : const AppState.unauthenticated(),
      ){
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authorizationRepository.user.listen(
            (user) => add(AppUserChanged(user)));
  }

  final AuthorizationRepository _authorizationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authorizationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}
