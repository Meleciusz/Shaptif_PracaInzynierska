import 'package:flutter/material.dart';

class ExerciseVeryfiedIcon extends StatelessWidget {
  const ExerciseVeryfiedIcon({super.key, required this.veryfied});

  final bool veryfied;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Veryfied:  "),
        SizedBox(width: 5),
        veryfied ? Icon(Icons.check, color: Colors.green)
            : Icon(Icons.not_interested_rounded, color: Colors.red),
      ]
    );
  }
}