import 'dart:developer';

import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import '../../../new_training/widgets/new_training_builder.dart';
import 'header_tile.dart';

class TrainingPlayer extends StatefulWidget {
  const TrainingPlayer({super.key, required this.exercises, required this.allExercises});

  final List<String> exercises;
  final List<Exercise> allExercises;


  @override
  State<TrainingPlayer> createState() => _TrainingPlayerState();
}

class _TrainingPlayerState extends State<TrainingPlayer> {
  late PageController _pageController;

  @override
  initState() {
    exercises = widget.allExercises
        .where((exercise) => widget.exercises.contains(exercise.name))
        .toList();
    _pageController = PageController();
    sets = List.generate(widget.exercises.length, (index) => 0);
    weightsDouble = List.generate(widget.exercises.length, (index) => 0.0);
    exerciseIsClosed = List.generate(widget.exercises.length, (index) => false);
    widget.allExercises!.removeWhere((element) => widget.exercises.contains(element.name));
    originalExercises.addAll(widget.exercises);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Exercise> exercises = <Exercise>[];
  List<String> originalExercises = <String>[];
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
                    widget.exercises.clear();
                    log(widget.exercises.toString());
                    log(originalExercises.toString());
                    widget.exercises.addAll(originalExercises);
                  });
                 },
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.exercises.length + 1,
                  itemBuilder: (context, index) {

                    return
                    widget.exercises.length != index
                        ? ExercisePage(exercise: widget.exercises[index],
                      sets: sets[index],
                      allExercises: widget.allExercises,
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
                      }
                    ) : QuickExerciseAdd(
                      allExercises: widget.allExercises,
                      actualExercises: exercises,
                      callbackAddExercise: (List<Exercise> exercise){
                        setState(() {
                          widget.exercises.addAll(exercise.map((e) => e.name));
                          exercises.addAll(exercise);
                          widget.allExercises!.removeWhere((element) => exercise.contains(element));
                          sets.addAll(List.generate(exercise.length, (index) => 0));
                          weightsDouble.addAll(List.generate(exercise.length, (index) => 0.0));
                          exerciseIsClosed.addAll(List.generate(exercise.length, (index) => false));
                        });
                      },
                      callbackRemoveExercise: (List<Exercise> exercise, List<int> indices){
                        setState(() {
                          indices.sort((a, b) => b.compareTo(a));

                          indices.forEach((index) {
                            if(index >= 0 && index < exercise.length){
                              widget.exercises.removeAt(index);
                              exercises.removeAt(index);
                              sets.removeAt(index);
                              weightsDouble.removeAt(index);
                              exerciseIsClosed.removeAt(index);
                            }
                          });

                          widget.allExercises!.addAll(exercise);

                        });
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
                          if (_pageController.page! < widget.exercises.length) {
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

typedef Callback = void Function(double weight);

class ExercisePage extends StatefulWidget {
  const ExercisePage(
      {super.key, required this.exercise, required this.sets,
        required this.onTapSets, required this.onLongPressSets, required this.exerciseIsClosed, required this.onPressExerciseIsClosed,
        required this.weight, required this.callbackWeight, required this.allExercises
      });

  final String exercise;
  final int sets;
  final VoidCallback onTapSets;
  final VoidCallback onLongPressSets;
  final VoidCallback onPressExerciseIsClosed;
  final Callback callbackWeight;
  final bool exerciseIsClosed;
  final double weight;
  final List<Exercise> allExercises;

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
    );
  }
}


typedef CallbackAddExercise = void Function(List<Exercise> choosedExercises);
typedef CallbackRemoveExercise = void Function(List<Exercise> choosedExercises, List<int> indexes);

class QuickExerciseAdd extends StatelessWidget {
  const QuickExerciseAdd({super.key, required this.allExercises,
    required this.callbackAddExercise, required this.callbackRemoveExercise,
    required this.actualExercises
  });

  final List<Exercise> allExercises;
  final CallbackAddExercise callbackAddExercise;
  final CallbackRemoveExercise callbackRemoveExercise;
  final List<Exercise> actualExercises;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewTrainingBuilder(allExercises: actualExercises)
                      )
                  ).then((value) {
                    if(value != null){
                      List<int> indices = [];
                      List<Exercise> chosenExercises = value;

                      chosenExercises.forEach((element) {
                        int index = actualExercises.indexOf(element);
                        if(index != -1){
                          indices.add(index);
                        }
                      });
                      callbackRemoveExercise(value, indices);
                    }
                  });
                },
                icon: const Icon(Icons.remove, size: 40,),
              ),
              Text("Remove exercise", style: Theme.of(context).textTheme.titleMedium,),
            ]
          )
        ],
      )
    );
  }
}
