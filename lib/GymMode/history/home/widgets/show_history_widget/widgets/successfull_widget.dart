import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

import 'history_item.dart';

class ShowHistorySuccessWidget extends StatelessWidget {
  const ShowHistorySuccessWidget({super.key, required this.history});
  final List<History>? history;
  final title = 'History';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          height:
          ((100 * history!.length) + MediaQuery.of(context).size.width) + 24.0,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return HistoryItem(
                historyItem: history![index],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: history!.length,
          ),
        ),
      ],
    );
  }
}