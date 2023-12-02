import 'package:container_body/container_body.dart';
import 'package:flutter/material.dart';
import 'package:training_repository/training_repository.dart';
import '../trainings_description.dart';

/*
 * Main description:
 * This class describes training description screen
 */
class TrainingsDescription extends StatelessWidget {
  const TrainingsDescription({super.key, required this.training});
  final Training training;

  static const mainColor = Color.fromARGB(255, 120, 178, 124);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
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
                  const Icon(Icons.checklist_rounded, size: 100, color: mainColor),
                  const SizedBox(height: 20),

                  //show name
                  Center(
                    child: Text(training.name ?? '',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  //show image
                  ImageProcessor(allUsedBodyParts: training.allBodyParts, mainlyUsedBodyPart: training.mainlyUsedBodyPart,),

                  //show exercises list
                  Text("Exercises list:", style: Theme.of(context).textTheme.headlineMedium,),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: training.exercises.map((element) {
                      return Text(
                        "    $element",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  //show description
                  Text("Description:", style: Theme.of(context).textTheme.headlineMedium,),
                  Text(training.description, style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 20),
                ]
            ),
          ]
        )
      ),
    );
  }
}