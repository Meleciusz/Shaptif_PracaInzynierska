import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';

class HistoryItemElements extends StatelessWidget {
  const HistoryItemElements({Key? key, required this.elements});

  final List<History> elements;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text("${elements[index].name}  ${elements[index].date}",
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(int n =0; n < elements[index].exercises_name.length; n++)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(elements[index].exercises_name[n]),
                                Text("Ilość powtórzeń: ${elements[index].exercises_sets_count[n]}"),
                                Text("Ciężary: ${elements[index].exercises_weights[n]}"),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          SizedBox(height: 8.0),

                        ],
                      ),
                    ),
                  ],
                );
              },
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
              separatorBuilder: (_, __) => const SizedBox(height: 20.0),
              itemCount: elements.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
