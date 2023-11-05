import 'package:container_body/container_body.dart';
import 'package:flutter/material.dart';
import 'package:training_repository/training_repository.dart';
import '../trainings_description.dart';

class TrainingsDescription extends StatelessWidget {
  const TrainingsDescription({super.key, required this.training});
  final Training training;

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
                  Center(
                    child: Text(training.name ?? '',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ImageProcessor(allUsedBodyParts: training.allBodyParts,),
                ]
            ),
          ]
        )
      ),
    );
  }
}