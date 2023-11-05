import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:training_repository/training_repository.dart';

import 'title_widget.dart';


class TrainingsByCategoryItem extends StatelessWidget {
  const TrainingsByCategoryItem({super.key, required this.training});
  final Training training;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Stack(
        children: [
          Container(
            width: 270.0,
            height: 150.0,
          ),
          Positioned(
            bottom: 0.0,
            child: TrainingsByCategoryTitle(
              name: training.name,
            ),
          ),
        ],
    ),
    );
  }
}
