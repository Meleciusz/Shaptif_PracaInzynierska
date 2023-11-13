import 'package:container_body/container_body.dart';
import 'package:flutter/material.dart';
import 'header_tile.dart';

class TrainingPlayer extends StatefulWidget {
  const TrainingPlayer({super.key, required this.exercises});

  final List<String> exercises;


  @override
  State<TrainingPlayer> createState() => _TrainingPlayerState();
}

class _TrainingPlayerState extends State<TrainingPlayer> {

  @override
  initState() {
    sets = List.generate(widget.exercises.length, (index) => 0);
    super.initState();
  }

  List<int> sets = <int>[];
  List<String> weights = <String>[];
  List<double> weightsDouble = <double>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
        child: Column(
            children: [
              const HeaderTitle(),
              Expanded(
                child: PageView.builder(
                  itemCount: widget.exercises.length,
                  itemBuilder: (context, index) {
                    return ExercisePage(exercise: widget.exercises[index]);
                  },
                ),
              ),
            ]
        ),
      )
    );
  }
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key, required this.exercise});
  final String exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(exercise, style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ), overflow: TextOverflow.ellipsis,),
      ]
    );
  }
}