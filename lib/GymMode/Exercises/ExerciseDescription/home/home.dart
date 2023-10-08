import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import '../widgets/container_body.dart';
import '../widgets/image_manager.dart';
import 'widgets/widgets.dart';


class ExerciseDescription extends StatefulWidget {
  const ExerciseDescription({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseDescription> createState() => _ExerciseDescriptionState();
}

 class _ExerciseDescriptionState extends State<ExerciseDescription> {
  final _avatarSize = 40.0;

  bool iconController = false;
  void _toggleIcon() {
    setState(() {
      iconController = !iconController;
    });
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderTitle(name: widget.exercise.name),
              const SizedBox(height: 20),
              ContainerBody(
                children: [
                  // CircleAvatar(
                  //   radius: 150.0,
                  //   child: iconController
                  //       ? Icon(Icons.add, size: _avatarSize)
                  //       : Icon(Icons.ac_unit, size: _avatarSize),
                  // ),
                  // GestureDetector(
                  //   onTap: _toggleIcon,
                  //   child: Icon(Icons.refresh),
                  // ),
                  CircleAvatar(
                    radius: 190.0,
                    child: ImageProcessor(exercise: widget.exercise),
                  ),
                  //ImageProcessor(exercise: widget.exercise),
                ],
              ),
            ]
        ),
      )
    );
  }
}