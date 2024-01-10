import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_repository/history_repository.dart';
import '../home.dart';

/*
 * Main description:
This is the history home page
This class is used to provide bloc and repository to history layout
 */

class HomePageHistory extends StatelessWidget {
  const HomePageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return  RepositoryProvider(
      create: (context) => FirestoreHistoryService(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<ShowHistoryWidgetBloc>(
                create: (context) => ShowHistoryWidgetBloc(
                  historyRepository: context.read<FirestoreHistoryService>(),
                )..add(GetHistoryEvent()),
              )
            ],
            child: const HomeLayout()
        )
    );
  }
}