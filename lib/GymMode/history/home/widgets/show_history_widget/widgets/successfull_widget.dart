import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

class ShowHistorySuccessWidget extends StatelessWidget {
  const ShowHistorySuccessWidget({super.key, required this.history});
  final List<History>? history;

  @override
  Widget build(BuildContext context) {
    return Text(history!.first.name);
  }
}