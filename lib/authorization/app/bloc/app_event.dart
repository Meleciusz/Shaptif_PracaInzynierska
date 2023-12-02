part of 'app_bloc.dart';

/*
 * Main description:
This file contains every event that bloc can have
 */

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final User user;
}
