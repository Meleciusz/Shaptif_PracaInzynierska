import 'package:flutter/material.dart';

//this function is used to return weight every time it is changed
typedef Callback = void Function(double weight);

//this function is used to return weight in String format when user finished exercise
typedef CallbackAllWeight = void Function(String weights);

/*
  * Main description:
this class represents one training page(exercises to made + last page for adding, saving and removing exercises)
 */
class ExercisePage extends StatefulWidget {
  const ExercisePage(
      {super.key, required this.exerciseName, required this.sets,
        required this.onTapSets, required this.onLongPressSets, required this.exerciseIsClosed, required this.onPressExerciseIsClosed,
        required this.weight, required this.callbackWeight, required this.activeDeleteMode, required this.callbackDelete,
        required this.exerciseDonePreviously, required this.allWeightsDouble,
      });

  //exercise name
  final String exerciseName;

  //sets
  final int sets;

  //add set after click
  final VoidCallback onTapSets;

  //remove all sets after long press
  final VoidCallback onLongPressSets;

  //close exercise after click
  final CallbackAllWeight onPressExerciseIsClosed;

  //return weight
  final Callback callbackWeight;

  //value that indicates if exercise is closed
  final bool exerciseIsClosed;

  //weight
  final double weight;

  //if active delete mode is on
  final bool activeDeleteMode;

  //delete exercise
  final VoidCallback callbackDelete;

  //if exercise was done previously
  final bool exerciseDonePreviously;

  //all weights
  final List<double> allWeightsDouble;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  @override
  initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
    //check if exercise was done previously
      widget.exerciseDonePreviously
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          Text(widget.exerciseName, style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ), overflow: TextOverflow.ellipsis,),
          SizedBox(height: MediaQuery.of(context).size.height * .05,),
          const Text("Exercise was already done", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ), overflow: TextOverflow.ellipsis,),
          SizedBox(height: MediaQuery.of(context).size.height * .15,),
          const Icon(Icons.account_tree_rounded, size: 100, color: Color.fromARGB(255, 214, 189, 219),),
        ],
      ): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .05,),
            Text(widget.exerciseName, style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ), overflow: TextOverflow.ellipsis,),
            GestureDetector(
              //add set (+1)
              onTap: () {
                widget.allWeightsDouble.add(widget.weight);
                widget.onTapSets();
              },
              //remove all sets
              onLongPress: () {
                widget.allWeightsDouble.clear();
                widget.onLongPressSets();
              },
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
                //change weight
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
                  //checks if exercise can be deleted or not and show message
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

                  //close exercise/open exercise
                  Tooltip(
                    message: widget.exerciseIsClosed ?  "Reverse mark" : "Mark exercise as completed" ,
                    child: IconButton(
                        onPressed: (){
                          widget.onPressExerciseIsClosed(widget.allWeightsDouble.join(', '));
                        },
                        icon: widget.exerciseIsClosed ? const Icon(Icons.enhanced_encryption, color: Colors.redAccent, size: 40,)
                            : const Icon(Icons.enhanced_encryption, color: Colors.green, size: 40,)
                    ),
                  ),
                ]
            )
          ]
      );
  }
}