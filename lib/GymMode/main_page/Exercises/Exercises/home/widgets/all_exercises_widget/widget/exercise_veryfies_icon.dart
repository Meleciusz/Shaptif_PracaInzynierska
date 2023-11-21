import 'package:flutter/material.dart';


class ExerciseVeryfiedIcon extends StatelessWidget {
  const ExerciseVeryfiedIcon({super.key, required this.veryfied, required this.addingUserName});

  final String addingUserName;
  final bool veryfied;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        const Text("Verified:  "),
        const SizedBox(width: 3),
        veryfied ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Icons.not_interested_rounded, color: Colors.red),
        const SizedBox(width: 3),
        veryfied ? Container() :
        Text("Added by:  $addingUserName" ?? ''),
      ]
    );
  }
}