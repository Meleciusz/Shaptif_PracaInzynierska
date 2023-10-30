import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.historyItem});

  final History historyItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey.withOpacity(.1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 25.0,
            left: 100.0,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Text(
                historyItem.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}