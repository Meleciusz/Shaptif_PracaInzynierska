import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../authorization/app/app.dart';


class ExerciseVeryfiedIcon extends StatelessWidget {
  const ExerciseVeryfiedIcon({super.key, required this.veryfied, required this.addingUserName});

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