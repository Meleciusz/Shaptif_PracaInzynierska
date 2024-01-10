import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:shaptifii/gym_mode/main_page/trainings/training_play/widgets/training_player/exercise_item.dart';
import 'package:shaptifii/gym_mode/main_page/trainings/training_play/widgets/training_player/training_change.dart';
import 'package:training_repository/training_repository.dart';
import '../../../new_training/widgets/new_training_builder.dart';
import 'header_tile.dart';
import 'return.dart';


/*
 * Main description:
This class describes look of training player screen, generates screens for each exercise and additional one to change training
 */
class TrainingPlayer extends StatefulWidget {
  const TrainingPlayer({super.key, required this.exercisesNames, required this.allExercises,
    required this.training, required this.returnValues
  });

  //list of all exercises names
  final List<String> exercisesNames;

  //list of all exercises
  final List<Exercise> allExercises;

  //chosen training
  final Training training;

  //values that'll be returned
  final Return returnValues;




  @override
  State<TrainingPlayer> createState() => _TrainingPlayerState();
}

class _TrainingPlayerState extends State<TrainingPlayer> {

  //page controller - controls which page is visible for user
  late PageController _pageController;

  //initialization of variables
  @override
  initState() {
    originalAllExercises.addAll(widget.allExercises);
    allExercises.addAll(widget.allExercises);
    widget.allExercises!.removeWhere((element) => widget.exercisesNames.contains(element.name));

    _pageController = PageController();
    sets = List.generate(widget.exercisesNames.length, (index) => 0);
    weights = List.generate(widget.exercisesNames.length, (index) => "0.0");
    weightsDouble = List.generate(widget.exercisesNames.length, (index) => 0.0);
    allWeightsDouble = List.generate(widget.exercisesNames.length, (index) => []);
    exerciseIsClosed = List.generate(widget.exercisesNames.length, (index) => false);
    exerciseDonePrevious = List.generate(widget.exercisesNames.length, (index) => false);

    //initialize values that controls if exercise was done previously
    for (int i = 0; i < widget.returnValues.isFinished.length; i++) {
      if (widget.returnValues.isFinished[i]) {
        if (i != -1) {
          exerciseIsClosed[i] = true;
          exerciseDonePrevious[i] = true;
        }
      }
    }

    originalExercisesNames.addAll(widget.exercisesNames);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //list that controls if exercise was done previously
  List<bool> exerciseDonePrevious = <bool>[];

  //original list of all exercises
  List<Exercise> originalAllExercises = <Exercise>[];

  //if user want to save as a new training
  bool wantToSave = false;

  //list of all exercises
  List<Exercise> allExercises = <Exercise>[];

  //mode that is activated if user want to delete exercise from training
  bool activeDeleteMode = false;

  //list of added exercises to training
  Set<Exercise> addedExercises = {};

  //original list of exercise names
  List<String> originalExercisesNames = <String>[];

  //list that controls if exercise is closed
  List<bool> exerciseIsClosed = <bool>[];

  //list of sets
  List<int> sets = <int>[];

  //list of weights in String format(String is original database format for weight)
  List<String> weights = <String>[];

  //list of weights(for one training) in double format
  List<double> weightsDouble = <double>[];

  //title of page
  String title = 'Save as new training';

  //used color
  Color color = Colors.black38;

  //list of all weights in double format
  List<List<double>> allWeightsDouble = <List<double>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
        child: Column(
            children: [
              HeaderTitle(

                //refresh training and reset all values
                onRefreshTap: (){
                  setState(() {
                    widget.exercisesNames.clear();
                    widget.exercisesNames.addAll(originalExercisesNames);
                    widget.allExercises.clear();
                    wantToSave = false;
                    activeDeleteMode = false;
                    addedExercises = {};

                    sets = List.generate(widget.exercisesNames.length, (index) => 0);
                    weights = List.generate(widget.exercisesNames.length, (index) => "0.0");
                    weightsDouble = List.generate(widget.exercisesNames.length, (index) => 0.0);
                    allWeightsDouble = List.generate(widget.exercisesNames.length, (index) => []);
                    exerciseIsClosed = List.generate(widget.exercisesNames.length, (index) => false);
                    exerciseDonePrevious = List.generate(widget.exercisesNames.length, (index) => false);

                    for (int i = 0; i < widget.returnValues.isFinished.length; i++) {
                      if (widget.returnValues.isFinished[i]) {
                        if (i != -1) {
                          exerciseIsClosed[i] = true;
                          exerciseDonePrevious[i] = true;
                        }
                      }
                    }
                  });
                 },
                onExitTap: (){
                  onExit();
                },
              ),

              //generate screens for each exercise and additional one to change training
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.exercisesNames.length + 1,
                  itemBuilder: (context, index) {

                    return
                    widget.exercisesNames.length != index
                        ? ExercisePage(
                      allWeightsDouble: allWeightsDouble[index],
                      exerciseDonePreviously: exerciseDonePrevious[index],
                      activeDeleteMode: activeDeleteMode,
                        exerciseName: widget.exercisesNames[index],
                      sets: sets[index],
                      weight: weightsDouble[index],

                      //change weight of changed exercise
                      callbackWeight: (double value){
                        setState(() {
                          weightsDouble[index] = value;
                        });
                      },

                      //add 1 to sets of changed exercise
                      onTapSets: (){
                        exerciseIsClosed[index] ? null :
                       sets[index]<1000 ?
                        setState(() {
                          sets[index]++;
                        }) : sets[index]=999;
                      },
                      exerciseIsClosed: exerciseIsClosed[index],

                      //set sets to 0 of changed exercise
                      onLongPressSets: (){
                        exerciseIsClosed[index] ? null :
                        setState(() {
                          sets[index]=0;
                        });
                      },

                      //close or open changed exercise
                      onPressExerciseIsClosed: (String allWeights){
                        setState(() {
                          weights[index] = allWeights;
                          exerciseIsClosed[index] = !exerciseIsClosed[index];
                        });

                        //check if all exercises are closed
                        bool allTrue = exerciseIsClosed.every((e) => e);


                        //if all exercises are closed, ask if user want to end training
                        allTrue ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            title: const Text("Are you sure?"),
                            content: const Text("Do you want to end training?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  onExit();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    backgroundColor: Colors.red
                                ),
                                child: const Text("End training"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    exerciseIsClosed[index] = !exerciseIsClosed[index];
                                  });

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    backgroundColor: Colors.green
                                ),
                                child: const Text("Go back"),
                              ),
                            ],
                          );
                        },
                        ) : null;
                      },

                      //delete exercise
                      callbackDelete: (){
                        setState(() {
                          activeDeleteMode = false;
                          allExercises.forEach((element) {
                            if(element.name == widget.exercisesNames[index]){
                              widget.allExercises.add(element);
                              addedExercises.remove(widget.allExercises.last);
                            }
                          });


                          exerciseDonePrevious.removeAt(index);
                          widget.exercisesNames.removeAt(index);
                          sets.removeAt(index);
                          allWeightsDouble.removeAt(index);
                          weightsDouble.removeAt(index);
                          weights.removeAt(index);
                          exerciseIsClosed.removeAt(index);


                          //check if all exercises are closed(If previous exercise was closed and user
                          //delete current exercise, then all exercises are closed, so ask if user want to end training)
                          bool allTrue = exerciseIsClosed.every((e) => e);
                          allTrue ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: const Text("Are you sure?"),
                                content: const Text("Do you want to end training?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      onExit();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        backgroundColor: Colors.red
                                    ),
                                    child: const Text("End training"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        exerciseDonePrevious[exerciseIsClosed.length - 1] != true ?
                                        exerciseIsClosed.last = !exerciseIsClosed.last : null;
                                      });

                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        backgroundColor: Colors.green
                                    ),
                                    child: const Text("Go back"),
                                  ),
                                ],
                              );
                            },
                          ) : null;
                        });
                      },

                    )

                        //additional page to change training
                  : TrainingChange(
                      title: title,
                      color: color,
                      canBeSaved: listEquals(widget.exercisesNames, originalExercisesNames),
                      allExercises: widget.allExercises,

                      //save as new training/don't save as new training
                      callbackSave: (){
                        setState(() {
                          wantToSave = !wantToSave;
                          title = wantToSave ? "This training will be saved" : "Training won't be saved";
                          color = wantToSave ? Colors.green : Colors.redAccent;
                        });
                      },

                      // add exercises
                      callbackAddExercise: (List<Exercise> exercise){
                        setState(() {
                          addedExercises.addAll(exercise);
                          widget.exercisesNames.addAll(exercise.map((e) => e.name));
                          widget.allExercises!.removeWhere((element) => exercise.contains(element));
                          sets.addAll(List.generate(exercise.length, (index) => 0));
                          weightsDouble.addAll(List.generate(exercise.length, (index) => 0.0));
                          allWeightsDouble.addAll(List.generate(exercise.length, (index) => []));
                          weights.addAll(List.generate(exercise.length, (index) => "0.0"));
                          exerciseIsClosed.addAll(List.generate(exercise.length, (index) => false));
                          exerciseDonePrevious.addAll(List.generate(exercise.length, (index) => false));
                        });
                      },

                      //remove exercise
                      callbackRemoveExercise: (){
                        activeDeleteMode = true;

                        if (_pageController.page! > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    );
                  },
                ),
              ),

              //buttons to change exercises(left or right)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Tooltip(
                    message: "Previous exercise",
                    child: IconButton(
                        onPressed: (){
                          if (_pageController.page! > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        icon: const Icon(Icons.keyboard_double_arrow_left_outlined)
                    ),
                  ),
                  Tooltip(
                    message: "Next exercise",
                    child: IconButton(
                        onPressed: (){
                          if (_pageController.page! < widget.exercisesNames.length) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        icon: const Icon(Icons.keyboard_double_arrow_right_sharp)
                    ),
                  ),
                ],
              ),
          ]
        )
      )
    );
  }

  //function that is called when user decide to exit from training
  void onExit(){
    setState(() {
      widget.returnValues.exercisesWeights = weights;
      widget.returnValues.exercisesSetsCount = sets;
      widget.returnValues.wantToSave = wantToSave;
      widget.returnValues.exercisesNames = widget.exercisesNames;
    });

    widget.exercisesNames.isNotEmpty ?


    //if user want to save training and there are exercises in training(Return changed training values)
    wantToSave ?
    {

      setState(() {
        List<String> allBodyParts = originalAllExercises
            .where((e) => widget.exercisesNames.contains(e.name))
            .expand((e) => e.body_parts_name)
            .toList();

        widget.returnValues.isFinished = exerciseIsClosed;
        widget.returnValues.allBodyParts = allBodyParts.toSet().toList();


        allBodyParts.isNotEmpty ?
        widget.returnValues.mainlyUsedBodyPart = findMainlyUsedBodyPart(allBodyParts)
            : widget.returnValues.mainlyUsedBodyPart = "No body part";

      }),
      Navigator.of(context).pop(widget.returnValues)
    }
    //if user don't want to save training and there are exercises in training(Return original training values)
    : {
      widget.training.exercises = originalExercisesNames,
      widget.returnValues.exercisesNames = widget.exercisesNames,

      if(exerciseIsClosed.length < widget.returnValues.isFinished.length )
        {
          setState(() {
            exerciseIsClosed.addAll(widget.returnValues.isFinished.sublist(0, exerciseIsClosed.length));
          }),
        },


      widget.returnValues.isFinished = exerciseIsClosed,



      Navigator.of(context).pop(widget.returnValues)
    }

    // if there are no exercises in training show an alert
    : showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text("You can't do that"),
          content: const Text("Training should have at least one exercise"),
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
      },
    );
  }
}

// find the main body part
String findMainlyUsedBodyPart(List<String> allBodyParts) {
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


// check if two lists are equal
bool listEquals(List<dynamic> a, List<dynamic> b) {
  if(a.length != b.length){
    return true;
  }

  for(int i = 0; i < a.length; i++){
    if(a[i] != b[i]){
      return true;
    }
  }
  return false;
}


