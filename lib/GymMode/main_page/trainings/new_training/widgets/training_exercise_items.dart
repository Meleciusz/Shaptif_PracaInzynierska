import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';


/*
 * Main description:
 This file describes item of list of exercises added to training
 */
class TrainingExerciseItems extends StatefulWidget {
  const TrainingExerciseItems({super.key, required this.exercises,
    required this.onAddExerciseCallback
  });

  final List<Exercise> exercises;
  final VoidCallback onAddExerciseCallback;

  @override
  State<TrainingExerciseItems> createState() => TrainingExerciseItemsState();
}

class TrainingExerciseItemsState extends State<TrainingExerciseItems> {
  static const mainColor = Color.fromARGB(255, 120, 178, 124);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height:
          ((120 * widget.exercises.length + 1) + MediaQuery.of(context).size.width),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return index != widget.exercises.length ?

                Container(
                height: 90.0,
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
                      top: 35.0,
                      left: 15.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text( "Used body parts:  ",
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 55.0,
                      left: 15.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Text(widget.exercises[index].body_parts.join(', '),
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ) :

              SizedBox(
                height: 50.0,
                child: Tooltip(
                  message: "Add exercises",
                  child: IconButton(
                    onPressed: (){
                      widget.onAddExerciseCallback();
                    },
                    icon: const Icon(Icons.add, color: mainColor, size: 50,
                      shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 2)],
                    ),
                  ),
                )
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: widget.exercises.length + 1,
          ),
        ),
      ],
    );
  }
}