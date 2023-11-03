import 'package:authorization_repository/authorization_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/authorization/app/app.dart';
import 'package:shaptifii/theme.dart';

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

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages
      ),
    );
  }
}
