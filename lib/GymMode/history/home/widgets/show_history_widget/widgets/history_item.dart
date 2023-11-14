import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

import 'history_elements/history_item_elements.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.historyItem, required this.elements});

  final String historyItem;
  final List<History> elements;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HistoryItemElements(elements: elements)));
      },
      child: Container(
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(.1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15.0,
            left: 15.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(
                historyItem ?? '',
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: -10.0,
            left: MediaQuery.of(context).size.width * .3,
            child: SizedBox(
              //width: MediaQuery.of(context).size.width * .5,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "History records: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${elements.where((element) => element.name == historyItem).length}",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // Text( "History records:  ${elements.where((element) => element.name == historyItem).length}",
              //   style: Theme.of(context).textTheme.titleSmall,
              //   overflow: TextOverflow.ellipsis,
              // ),
            ),
          ),
        ],
      ),
     ),
    );
  }
}