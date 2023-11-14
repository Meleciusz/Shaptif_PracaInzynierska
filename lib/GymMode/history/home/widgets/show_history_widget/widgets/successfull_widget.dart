import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

import 'history_item.dart';

class ShowHistorySuccessWidget extends StatelessWidget {
  ShowHistorySuccessWidget({super.key, required this.history});
  static const mainColor = Color.fromARGB(255, 79, 171, 151);
  final List<History>? history;

  final Set<String> historyUniqueNames ={};

  @override
  Widget build(BuildContext context) {
    if(history!.isNotEmpty){
      history!.forEach((element) {
        historyUniqueNames.add(element.name!);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.history, size: 100.0, color: mainColor,
          shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
        ),
        SizedBox(
          height:
          ((100 * historyUniqueNames.length) + MediaQuery.of(context).size.width) + 24.0,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return HistoryItem(
                historyItem: historyUniqueNames.elementAt(index),
                elements : history!.where((element) => element.name == historyUniqueNames.elementAt(index)).toList(),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: historyUniqueNames.length,
          ),
        ),
      ],
    );
  }
}