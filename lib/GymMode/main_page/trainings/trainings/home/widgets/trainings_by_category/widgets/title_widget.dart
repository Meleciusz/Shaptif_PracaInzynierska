import 'package:flutter/material.dart';

class TrainingsByCategoryTitle extends StatelessWidget {
  const TrainingsByCategoryTitle({super.key, required this.name,});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      alignment: Alignment.centerLeft,
      height: 50.0,
      width: 270.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}