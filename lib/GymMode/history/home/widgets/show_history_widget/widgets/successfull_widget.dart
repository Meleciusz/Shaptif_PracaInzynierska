import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';
import 'history_item.dart';

/*
* Main description:
This class describes history screen
 */

class ShowHistorySuccessWidget extends StatelessWidget {
  ShowHistorySuccessWidget({super.key, required this.history});
  static const mainColor = Color.fromARGB(255, 79, 171, 151);

  //every history records
  final List<History>? history;

  //history records names
  final Set<String> historyUniqueNames ={};

  @override
  Widget build(BuildContext context) {

    //fill historyUniqueNames only with unique names from history records
    fillUniqueNames();

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

              //show every history record
              return HistoryItem(
                historyItemName: historyUniqueNames.elementAt(index),
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

  void fillUniqueNames(){
    if(history!.isNotEmpty){
      history!.forEach((element) {
        historyUniqueNames.add(element.name);
      });
    }
  }
}

