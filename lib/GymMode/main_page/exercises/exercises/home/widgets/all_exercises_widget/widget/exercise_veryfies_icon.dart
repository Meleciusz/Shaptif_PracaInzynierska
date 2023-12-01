import 'package:flutter/material.dart';


/*
*Main description:
This class show if exercise is verified and show user who added this exercise
 */
class ExerciseVerifiedIcon extends StatelessWidget {
  const ExerciseVerifiedIcon({super.key, required this.verified, required this.addingUserName});

  final String addingUserName;
  final bool verified;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        const Text("Verified:  "),
        const SizedBox(width: 3),
        verified ? const Icon(Icons.check, color: Colors.green)
            : const Icon(Icons.not_interested_rounded, color: Colors.red),
        const SizedBox(width: 3),
        verified ? Container() :
        Text("Added by:  $addingUserName" ?? ''),
      ]
    );
  }
}