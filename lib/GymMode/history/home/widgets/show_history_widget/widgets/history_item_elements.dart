import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

class HistoryItemElements extends StatelessWidget {
  const HistoryItemElements({super.key, required this.elements});

  final List<History> elements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_return_outlined),
      ),
    );

  }
}