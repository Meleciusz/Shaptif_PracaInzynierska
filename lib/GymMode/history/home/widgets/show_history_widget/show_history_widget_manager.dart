import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/history/history.dart';
import 'widgets/widgets.dart';

/*
 * Main description:
 This class build screen basing on bloc state
 */

class ShowHistoryWidget extends StatelessWidget {
  const ShowHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowHistoryWidgetBloc, ShowHistoryWidgetState>(
        builder: (context, state) {
          return state.status.isSuccess
              ? ShowHistorySuccessWidget(
                    history: state.history,
                  )
              : state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.status.isError
                  ? const Center(child: Text("Error"))
                  : const SizedBox();
        }
    );
  }
}