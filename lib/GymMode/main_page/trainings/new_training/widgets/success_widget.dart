import 'dart:developer';

import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../../../authorization/app/bloc/app_bloc.dart';
import 'header_tile.dart';
import '../bloc/new_training_bloc.dart';
import 'widgets.dart';

class NewTrainingSuccess extends StatefulWidget {
  const NewTrainingSuccess({super.key, required this.allExercises});
  final List<Exercise>? allExercises;

  @override
  State<NewTrainingSuccess> createState() => NewTrainingSuccessState();
}

class NewTrainingSuccessState extends State<NewTrainingSuccess> {
  static const mainColor = Color.fromARGB(255, 120, 178, 124);


  @override
  initState(){
    originalExercises.addAll(widget.allExercises!);
    super.initState();
  }

  List<Exercise> originalExercises = <Exercise>[];
  List<Exercise> exercises = <Exercise>[];
  String trainingName = '';
  String trainingDescription = '';
  List<double> startingWeights = <double>[];
  List<String> allBodyParts = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderTitle(
                onRefreshTap: (){
                  setState(() {
                    exercises.clear();
                    trainingName = '';
                    trainingDescription = '';
                    startingWeights.clear();
                    allBodyParts.clear();

                    widget.allExercises!.clear();
                    widget.allExercises!.addAll(originalExercises!);
                    log(widget.allExercises.toString());
                    log(originalExercises.toString());
                  });
                },
              ),
              ContainerBody(
                  children: [
                    InkWell(
                      onTap: (){
                        exercises.isNotEmpty ?{
                          context.read<NewTrainingBloc>().add(AddNewTraining(training:
                          Training(
                          name: trainingName.isEmpty ? "Training${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" : trainingName,
                          description: trainingDescription,
                          exercises: exercises.map((e) => e.name).toList(),
                          startingWeight: startingWeights.map((e) => e.toString()).toList(),
                          allBodyParts: allBodyParts.toSet().toList(),
                          addingUserName: context.read<AppBloc>().state.user.name!,
                          addingUserId: context.read<AppBloc>().state.user.id!,
                          id: "",
                          verified: false,
                          isFinished: List.generate(exercises.length, (index) => false),
                          mainlyUsedBodyPart: findMainlyUsedBodyPart(exercises, allBodyParts),
                          ))),
                          //context.read<AllTrainingsBloc>().add(RefreshTrainings());
                          Navigator.pop(context),
                        } : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: Text("Wrong!", style: Theme.of(context).textTheme.titleLarge,),
                                content: Text("Add at least one exercise!", style: Theme.of(context).textTheme.titleMedium,),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        backgroundColor: Colors.red
                                    ),
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                      child: const Tooltip(
                        message: "Save",
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Icon(Icons.add_task_rounded, size: 100, color: mainColor),
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Training Name", style: Theme.of(context).textTheme.titleLarge, ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: trainingName.isEmpty ? "Training${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" : trainingName,
                        hintMaxLines: 15,
                        hintStyle: Theme.of(context).textTheme.titleLarge,
                        prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
                          color: mainColor,
                          shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
                        )), border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (text) {
                        setState(() {
                          trainingName = text;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Description", style: Theme.of(context).textTheme.titleLarge,),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.titleMedium,
                        prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
                          color: mainColor,
                          shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
                        )),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (text) {
                        setState(() {
                          trainingDescription = text;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    exercises.isNotEmpty
                      ? ImageProcessor(allUsedBodyParts: allBodyParts, mainlyUsedBodyPart: allBodyParts.isNotEmpty ? findMainlyUsedBodyPart(exercises, allBodyParts) : "",)
                      : const SizedBox(),
                    const SizedBox(height: 20),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Text("Exercises", style: Theme.of(context).textTheme.titleLarge,),
                    // ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.align_horizontal_left_rounded, color: mainColor, size: 70,
                            shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 2)],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * .2,),
                          Text("Exercises", style: Theme.of(context).textTheme.titleLarge,),
                        ]
                      )
                    ),
                    TrainingExerciseItems(
                      exercises: exercises, startingWeight: startingWeights.isEmpty
                        ? List.generate(exercises.length, (index) => 0.0)
                        : startingWeights,
                      callback: (List<double> weights) {
                        setState(() {
                          startingWeights = weights;
                        });
                      },
                      onAddExerciseCallback: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewTrainingBuilder(
                          allExercises: widget.allExercises,
                        ))).then((value){
                          if (value != null) {
                            List<Exercise> chosenExercises = value;

                            setState(() {
                              exercises.addAll(chosenExercises);
                              chosenExercises.forEach((exercise) => allBodyParts.addAll(exercise.body_parts));
                              widget.allExercises!.removeWhere((element) => chosenExercises.contains(element));
                            });
                          }
                        });
                      },
                    ),
                  ]
              )
            ]
        ),
      ),
    );
  }
}

String findMainlyUsedBodyPart(List<Exercise> exercises, List<String> allBodyParts) {
  var bodyPartCounts = <String, int>{};
  for (var bodyPart in allBodyParts) {
    bodyPartCounts[bodyPart] = (bodyPartCounts[bodyPart] ?? 0) + 1;
  }

  var mainlyUsedBodyPart = bodyPartCounts.entries.fold(
    bodyPartCounts.entries.first.key,
        (maxKey, entry) => entry.value > bodyPartCounts[maxKey]! ? entry.key : maxKey,
  );

  return mainlyUsedBodyPart;
}
