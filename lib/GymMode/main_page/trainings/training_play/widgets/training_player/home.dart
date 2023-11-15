import 'dart:developer';

import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../new_training/widgets/new_training_builder.dart';
import 'header_tile.dart';

typedef CallbackExercise = void Function(List<String> newExercises);

class TrainingPlayer extends StatefulWidget {
  const TrainingPlayer({super.key, required this.exercisesNames, required this.allExercises,});

  final List<String> exercisesNames;
  final List<Exercise> allExercises;



  @override
  State<TrainingPlayer> createState() => _TrainingPlayerState();
}

class _TrainingPlayerState extends State<TrainingPlayer> {
  late PageController _pageController;

  @override
  initState() {
    allExercises.addAll(widget.allExercises);
    widget.allExercises!.removeWhere((element) => widget.exercisesNames.contains(element.name));

    _pageController = PageController();
    sets = List.generate(widget.exercisesNames.length, (index) => 0);
    weightsDouble = List.generate(widget.exercisesNames.length, (index) => 0.0);
    exerciseIsClosed = List.generate(widget.exercisesNames.length, (index) => false);


    originalExercises.addAll(widget.exercisesNames);
    originalAllExercises.addAll(widget.allExercises);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Exercise> allExercises = <Exercise>[];
  bool activeDeleteMode = false;
  List<String> originalExercises = <String>[];
  List<Exercise> originalAllExercises = <Exercise>[];
  List<bool> exerciseIsClosed = <bool>[];
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
              HeaderTitle(
                onRefreshTap: (){
                  setState(() {
                    widget.exercisesNames.clear();
                    widget.exercisesNames.addAll(originalExercises);
                    widget.allExercises.clear();
                    widget.allExercises.addAll(originalAllExercises);
                  });
                 },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.exercisesNames.length + 1,
                  itemBuilder: (context, index) {

                    return
                    widget.exercisesNames.length != index
                        ? ExercisePage(
                      activeDeleteMode: activeDeleteMode,
                        exercise: widget.exercisesNames[index],
                      sets: sets[index],
                      weight: weightsDouble[index],
                      callbackWeight: (double value){
                        setState(() {
                          weightsDouble[index] = value;
                        });
                      },
                      onTapSets: (){
                        exerciseIsClosed[index] ? null :
                       sets[index]<1000 ?
                        setState(() {
                          sets[index]++;
                        }) : sets[index]=999;
                      },
                      exerciseIsClosed: exerciseIsClosed[index],
                      onLongPressSets: (){
                        exerciseIsClosed[index] ? null :
                        setState(() {
                          sets[index]=0;
                        });
                      },
                      onPressExerciseIsClosed: (){
                        setState(() {
                          exerciseIsClosed[index] = !exerciseIsClosed[index];
                        });
                      },
                      callbackDelete: (){
                        setState(() {
                          activeDeleteMode = false;
                          allExercises.forEach((element) {
                            if(element.name == widget.exercisesNames[index]){
                              widget.allExercises.add(element);
                            }
                          });

                          widget.exercisesNames.removeAt(index);
                          sets.removeAt(index);
                          weightsDouble.removeAt(index);
                          exerciseIsClosed.removeAt(index);
                        });
                      },

                    ) : QuickExerciseAdd(
                      canBeSaved: listEquals(widget.exercisesNames, originalExercises),
                      allExercises: widget.allExercises,
                      callbackSave: (){
                        //TODO
                      },
                      callbackAddExercise: (List<Exercise> exercise){
                        setState(() {
                          widget.exercisesNames.addAll(exercise.map((e) => e.name));
                          widget.allExercises!.removeWhere((element) => exercise.contains(element));
                          sets.addAll(List.generate(exercise.length, (index) => 0));
                          weightsDouble.addAll(List.generate(exercise.length, (index) => 0.0));
                          exerciseIsClosed.addAll(List.generate(exercise.length, (index) => false));
                        });
                      },
                      callbackRemoveExercise: (){
                        activeDeleteMode = true;
                      },
                    );
                  },
                ),
              ),
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
}

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

typedef Callback = void Function(double weight);
//typedef CallbackDelete = void Function();

class ExercisePage extends StatefulWidget {
  const ExercisePage(
      {super.key, required this.exercise, required this.sets,
        required this.onTapSets, required this.onLongPressSets, required this.exerciseIsClosed, required this.onPressExerciseIsClosed,
        required this.weight, required this.callbackWeight, required this.activeDeleteMode, required this.callbackDelete
      });

  final String exercise;
  final int sets;
  final VoidCallback onTapSets;
  final VoidCallback onLongPressSets;
  final VoidCallback onPressExerciseIsClosed;
  final Callback callbackWeight;
  final bool exerciseIsClosed;
  final double weight;
  final bool activeDeleteMode;
  final VoidCallback callbackDelete;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          Text(widget.exercise, style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ), overflow: TextOverflow.ellipsis,),
          GestureDetector(
            onTap: () => widget.onTapSets(),
            onLongPress: () => widget.onLongPressSets(),
            child: SizedBox(
              height: 120.0,
              child: Stack(
                  children: [
                    Positioned(
                      top: 70.0,
                      left: MediaQuery.of(context).size.width * .0,
                      child: widget.sets == 0 ? SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: const Icon(Icons.touch_app)
                      ) : const SizedBox()
                    ),
                    Positioned(
                      top: 90.0,
                      left: MediaQuery.of(context).size.width * .35,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: const Text(
                          "sets: ",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      left: MediaQuery.of(context).size.width * .45,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(
                            "${widget.sets}",
                            style: Theme.of(context).textTheme.displayLarge),
                      ),
                    ),
                  ]
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: widget.weight,
                max: 300,
                divisions: 30,
                activeColor: const Color.fromARGB(255, 214, 189, 219),
                inactiveColor: const Color.fromARGB(0, 255, 255, 255),
                onChanged: (double value) {
                  double roundedValue = double.parse(value.toStringAsFixed(2));
                  setState(() {
                    widget.callbackWeight(roundedValue);
                  });
                },
              ),
              Flexible(
                child: Text(
                  "${widget.weight}" " kg",
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Tooltip(
                message: "Remove 1.25kg",
                child: IconButton(
                    onPressed: (){
                      widget.weight > 1.25 ?
                      setState(() {
                        widget.callbackWeight(widget.weight - 1.25);
                      }) : null;
                    },
                    icon: const Icon(Icons.remove)
                ),
              ),
              Tooltip(
                message: "Add 1.25kg",
                child: IconButton(
                    onPressed: (){
                      widget.weight < 300 ?
                      setState(() {
                        widget.callbackWeight(widget.weight + 1.25);
                      }) : null;
                    },
                    icon: const Icon(Icons.add)
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.activeDeleteMode
                  ? Tooltip(
                message: "Delete exercise",
                child: IconButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            title: const Text("Are you sure?"),
                            content: const Text("If this exercise in no longer in the database and you decide later to overwrite this training this exercise will be deleted forever."),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  widget.callbackDelete();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    backgroundColor: Colors.red
                                ),
                                child: const Text("Delete"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                      );
                    },
                    icon: const Icon(Icons.delete, size: 40,)
                ),
              ) : Container(),

              Tooltip(
                message: widget.exerciseIsClosed ?  "Reverse mark" : "Mark exercise as completed" ,
                child: IconButton(
                    onPressed: (){
                      setState(() {
                        widget.onPressExerciseIsClosed();
                      });
                    },
                    icon: widget.exerciseIsClosed ? const Icon(Icons.no_encryption_gmailerrorred, color: Colors.redAccent, size: 40,)
                        : const Icon(Icons.enhanced_encryption, color: Colors.green, size: 40,)
                ),
              ),
            ]
          )

        ]
    );
  }
}


typedef CallbackAddExercise = void Function(List<Exercise> choosedExercises);

class QuickExerciseAdd extends StatelessWidget {
  const QuickExerciseAdd({super.key, required this.allExercises,
    required this.callbackAddExercise, required this.callbackRemoveExercise,
     required this.canBeSaved, required this.callbackSave
  });

  final List<Exercise> allExercises;
  final CallbackAddExercise callbackAddExercise;
  final VoidCallback callbackRemoveExercise;
  final bool canBeSaved;
  final VoidCallback callbackSave;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          canBeSaved ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){
                  callbackSave();
                },
                icon: const Icon(Icons.save_rounded, size: 40,),
              ),
              Text("Save changes", style: Theme.of(context).textTheme.titleMedium,),
            ]
          ) : const SizedBox(),
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewTrainingBuilder(allExercises: allExercises)
                      )
                  ).then((value) {
                    value == null ? null :
                    callbackAddExercise(value);
                  });
                },
                icon: const Icon(Icons.add, size: 40,),
              ),
              Text("Add exercise", style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){
                  callbackRemoveExercise();
                },
                icon: const Icon(Icons.remove, size: 40,),
              ),
              Text("Add exercise", style: Theme.of(context).textTheme.titleMedium,),
            ],
          ),
        ],
      )
    );
  }
}
