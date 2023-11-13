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
              const HeaderTitle(),
              ContainerBody(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("Training Name", style: Theme.of(context).textTheme.titleLarge,),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: trainingName.isEmpty ? "Training${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" : trainingName,
                        hintMaxLines: 15,
                        hintStyle: Theme.of(context).textTheme.titleLarge,
                        prefixIcon: const Icon(Icons.edit_attributes_sharp),
                        border: OutlineInputBorder(
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
                        hintText: "Nothing here yet",
                        hintStyle: Theme.of(context).textTheme.titleMedium,
                        prefixIcon: const Icon(Icons.edit_attributes_sharp),
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
                    ImageProcessor(allUsedBodyParts: allBodyParts, mainlyUsedBodyPart: allBodyParts.isNotEmpty ? findMainlyUsedBodyPart(exercises, allBodyParts) : "",),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Exercises", style: Theme.of(context).textTheme.titleLarge,),
                    ),
                    TrainingExerciseItems(
                      exercises: exercises, startingWeight: startingWeights.isEmpty
                        ? List.generate(exercises.length, (index) => 0.0)
                        : startingWeights,
                      callback: (List<double> weights) {
                        setState(() {
                          startingWeights = weights;
                        });
                      }
                    ),
                  ]
              )
            ]
        ),
      ),
      floatingActionButton: FabCircularMenu(
          children: <Widget>[
            Tooltip(
              message: "Select exercises",
              child: IconButton(icon: const Icon(Icons.content_paste_search_rounded),
                onPressed: (){
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
                }
                ,),
            ),
            Tooltip(
              message: "Save training",
              child: IconButton(icon: const Icon(Icons.save),
                onPressed: (){
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
                  )));
                  //context.read<AllTrainingsBloc>().add(RefreshTrainings());
                  Navigator.pop(context);
                },
              ),
            ),
            Tooltip(
              message: "Exit",
              child: IconButton(icon: const Icon(Icons.exit_to_app_sharp),
                onPressed: (){
                  Navigator.pop(context);
                }
                ,),
            ),
          ]
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
