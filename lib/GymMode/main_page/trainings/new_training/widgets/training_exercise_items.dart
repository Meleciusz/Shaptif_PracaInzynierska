import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

typedef WeightPicked = Function(List<double> weightPicked);

class TrainingExerciseItems extends StatefulWidget {
  const TrainingExerciseItems({super.key, required this.exercises, required this.startingWeight, required this.callback});

  final List<Exercise> exercises;
  final List<double> startingWeight;
  final WeightPicked callback;

  @override
  State<TrainingExerciseItems> createState() => TrainingExerciseItemsState();
}

class TrainingExerciseItemsState extends State<TrainingExerciseItems> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height:
          ((120 * widget.exercises.length) + MediaQuery.of(context).size.width),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.withOpacity(.1),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5.0,
                      left: 15.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          widget.exercises[index].name ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 5.0,
                        left: MediaQuery.of(context).size.width * .78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    widget.startingWeight[index]+=1.25;
                                  });
                                  widget.callback(widget.startingWeight);
                                },
                                icon: const Icon(Icons.add)
                            ),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    widget.startingWeight[index] >= 1.25
                                        ? widget.startingWeight[index] -= 1.25
                                        : widget.startingWeight[index] = 0;
                                  });
                                  widget.callback(widget.startingWeight);
                                },
                                icon: const Icon(Icons.remove)
                            ),
                          ]
                        )
                    ),
                    Positioned(
                        top: 5.0,
                        left: MediaQuery.of(context).size.width * .65,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      widget.startingWeight[index] += 10;
                                    });
                                    widget.callback(widget.startingWeight);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  )
                              ),
                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      widget.startingWeight[index] >= 10
                                          ? widget.startingWeight[index] -= 10
                                          : widget.startingWeight[index] = 0;
                                    });
                                    widget.callback(widget.startingWeight);
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  )
                              ),
                            ]
                        )
                    ),
                    Positioned(
                      top: 50.0,
                      left: 15.0,
                      child:
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .6,
                          child: Text( "Starting weight:  ${widget.startingWeight[index]}",
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ),
                    Positioned(
                      top: 90.0,
                      left: 15.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text( "Used body parts:  ${widget.exercises[index].body_parts.join(', ')}",
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: widget.exercises.length,
          ),
        ),
      ],
    );
  }
}