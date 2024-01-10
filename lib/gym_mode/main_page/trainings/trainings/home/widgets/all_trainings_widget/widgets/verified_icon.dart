import 'package:flutter/material.dart';

/*
  *Main description:
This class is used to display if training is verified or not.
 */
class AllTrainingsIcon extends StatelessWidget {
  const AllTrainingsIcon({super.key, required this.verified, required this.addingUserId});

  final String addingUserId;
  final bool verified;

  @override
  Widget build(BuildContext context) {

    return Row(
        children: [
          const Text("Verified:  "),
          const SizedBox(width: 3),
          verified ? const Icon(Icons.check, color: Colors.green)
              : const Icon(Icons.not_interested_rounded, color: Colors.red),
        ]
    );
  }
}