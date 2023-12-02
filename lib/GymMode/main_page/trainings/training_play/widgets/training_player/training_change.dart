import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:shaptifii/GymMode/main_page/trainings/new_training/widgets/new_training_builder.dart';

typedef CallbackAddExercise = void Function(List<Exercise> choosedExercises);

/*
  * Main description:
this class represents last page for adding, saving and removing exercises
 */
class TrainingChange extends StatelessWidget {
  const TrainingChange({super.key, required this.allExercises,
    required this.callbackAddExercise, required this.callbackRemoveExercise,
    required this.canBeSaved, required this.callbackSave, required this.title, required this.color
  });

  //list of all exercises
  final List<Exercise> allExercises;

  //function that adds exercises
  final CallbackAddExercise callbackAddExercise;

  //function that removes exercise
  final VoidCallback callbackRemoveExercise;

  //indicates if user want to save training as a new one
  final bool canBeSaved;

  //function that saves as a new training
  final VoidCallback callbackSave;

  //title
  final String title;

  //main color
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //if user want to save, save as a new training
            canBeSaved ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      callbackSave();
                    },
                    icon: Icon(Icons.save_rounded, size: 40, color: color,),
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleMedium,),
                ]
            ) : const SizedBox(),
            SizedBox(height: MediaQuery.of(context).size.height * .05,),

            //add exercises
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

            //remove exercise
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    callbackRemoveExercise();
                  },
                  icon: const Icon(Icons.remove, size: 40,),
                ),
                Text("Remove exercise", style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          ],
        )
    );
  }
}