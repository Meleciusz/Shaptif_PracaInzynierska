import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../../../authorization/app/bloc/app_bloc.dart';
import 'header_tile.dart';
import '../bloc/new_training_bloc.dart';
import 'widgets.dart';

/*
  *Main description:
this class describes look of new training page

* Navigator:
User can navigate to training builder(Screen with list of exercises)
 */
class NewTrainingSuccess extends StatefulWidget {
  const NewTrainingSuccess({super.key, required this.allExercises, required this.bodyParts});

  //list of all exercises
  final List<Exercise>? allExercises;

  //list of body parts
  final List<BodyParts> bodyParts;

  @override
  State<NewTrainingSuccess> createState() => NewTrainingSuccessState();
}

class NewTrainingSuccessState extends State<NewTrainingSuccess> {
  static const mainColor = Color.fromARGB(255, 120, 178, 124);


  @override
  initState(){

    //fill original exercises list
    originalExercises.addAll(widget.allExercises!);
    super.initState();
  }

  //list of original exercises(exercises from the beginning)
  List<Exercise> originalExercises = <Exercise>[];

  //list of exercises added to the training
  List<Exercise> exercises = <Exercise>[];

  //name of the training
  String trainingName = '';

  //description of the training
  String trainingDescription = '';

  //list of all body parts used in training
  List<String> allUsedBodyParts = <String>[];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderTitle(

                //refresh button
                onRefreshTap: (){
                  setState(() {
                    exercises.clear();
                    trainingName = '';
                    trainingDescription = '';
                    allUsedBodyParts.clear();

                    widget.allExercises!.clear();
                    widget.allExercises!.addAll(originalExercises!);
                  });
                },
              ),
              const SizedBox(height: 10,),
              ContainerBody(
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: [
                        Positioned(
                            width: MediaQuery.of(context).size.width * 0.7,
                            top: 40,
                            child: const Icon(Icons.touch_app_sharp, size: 30,)),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                          onTap: (){
                            exercises.isNotEmpty ?{
                              context.read<NewTrainingBloc>().add(AddNewTraining(training:
                              Training(
                                name: trainingName.isEmpty ? "Training${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" : trainingName,
                                description: trainingDescription,
                                exercises: exercises.map((e) => e.name).toList(),
                                allBodyParts: allUsedBodyParts.toSet().toList(),
                                addingUserId: context.read<AppBloc>().state.user.id!,
                                id: "",
                                verified: false,
                                isFinished: List.generate(exercises.length, (index) => false),
                                mainlyUsedBodyPart: findMainlyUsedBodyPart(exercises, allUsedBodyParts),
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
                        ),),
                      ]),
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
                        hintText: trainingDescription,
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
                      ? ImageProcessor(allUsedBodyParts: allUsedBodyParts,
                      mainlyUsedBodyPart: allUsedBodyParts.isNotEmpty ? findMainlyUsedBodyPart(exercises, allUsedBodyParts) : "",
                      bodyParts: widget.bodyParts,
                    )
                      : const SizedBox(),
                    const SizedBox(height: 20),
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
                      exercises: exercises,
                      onAddExerciseCallback: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewTrainingBuilder(
                          allExercises: widget.allExercises,
                        ))).then((value){
                          if (value != null) {
                            List<Exercise> chosenExercises = value;

                            setState(() {
                              exercises.addAll(chosenExercises);
                              chosenExercises.forEach((exercise) => allUsedBodyParts.addAll(exercise.body_parts));
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

//function that finds main body part used in training
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
