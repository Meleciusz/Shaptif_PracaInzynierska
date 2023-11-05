import 'package:flutter/material.dart';


class AllTrainingsIcon extends StatelessWidget {
  const AllTrainingsIcon({super.key, required this.veryfied, required this.addingUserName});

  final String addingUserName;
  final bool veryfied;

  @override
  Widget build(BuildContext context) {

    return Row(
        children: [
          Text("Veryfied:  "),
          SizedBox(width: 3),
          veryfied ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.not_interested_rounded, color: Colors.red),
          SizedBox(width: 3),
          veryfied ? Container() :
          Text("Added by:  " + addingUserName ?? ''),
        ]
    );
  }
}