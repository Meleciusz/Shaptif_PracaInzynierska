import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_repository/history_repository.dart';

import '../home.dart';
import 'home_layout.dart';

class HomePageHistory extends StatelessWidget {
  const HomePageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: RepositoryProvider(
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

      ),
    );
  }
}