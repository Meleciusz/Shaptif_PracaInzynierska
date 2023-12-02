import 'package:authorization_repository/authorization_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/app.dart';

/*
 * Main description:
This is the home page
This class is used to provide bloc and repository to layout
 */
class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
      return RepositoryProvider(
          create: (context) => AuthorizationRepository(),
        child: BlocProvider(
          create: (context) => AppBloc(
            authorizationRepository: context.read<AuthorizationRepository>(),
          ),
              child: const AppView(),
        ),
      );
  }
}

/*
 * Main description:
This is layout
This class define what is displayed on screen

* Main elements:
application can display login page or home page
 */
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: theme,
      home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages
      ),
    );
  }
}
