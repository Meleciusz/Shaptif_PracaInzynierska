import 'package:container_body/container_body.dart';
import 'package:flutter/material.dart';
import 'package:training_repository/training_repository.dart';
import 'board.dart';
import 'header_tile.dart';

class TrainingPlaySuccess extends StatelessWidget {
  const TrainingPlaySuccess({super.key, required this.allTrainings});

  final List<Training>? allTrainings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderTitle(),
            const SizedBox(height: 20),
            ContainerBody(
              children: [
                const Icon(Icons.bar_chart_sharp,
                  size: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Ended trainings", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(trainings: allTrainings!.where((element) => element.isFinished.every((e) => e == true)).toList(), mode: "Ended",),
                Container(
                  alignment: Alignment.center,
                  child: Text("Trainings in progress", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(trainings: allTrainings!.where((element) => element.isFinished.any((e) => e == true) && element.isFinished.any((e) => e == false)).toList(), mode: "Progress",),
                Container(
                  alignment: Alignment.center,
                  child: Text("Trainings to start", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(trainings: allTrainings!.where((element) => element.isFinished.every((e) => e == false)).toList(), mode: "Start",),
              ],
            ),
          ],
        )
      )
    );
  }
}