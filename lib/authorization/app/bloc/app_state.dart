part of 'app_bloc.dart';


/*
 * Main description:
This file contains every state that bloc can be in and values that can be used in the bloc
 */
enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable{
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}

