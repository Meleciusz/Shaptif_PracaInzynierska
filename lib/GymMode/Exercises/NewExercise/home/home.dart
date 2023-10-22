import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authorization/app/app.dart';
import '../../ExerciseDescription/widgets/container_body.dart';
import '../../Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import '../widgets/image_manager.dart';
import '../widgets/widgets.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({super.key, required this.allExercisesBloc});
  final AllExercisesBloc allExercisesBloc;

  @override
  State<NewExercise> createState() => _NewExerciseState();
}


class _NewExerciseState extends State<NewExercise> {

  final List<String> bodyPartsList = List.of(
      [
        "Adductor", "Biceps", "Butt", "Calf", "Chest", "CoreAbs", "Deltoid", "Dorsi", "DownAbs", "Femoris",
        "Forearm", "Quadriceps", "Rest", "Shoulders", "SideAbs", "Trapezius", "Triceps", "UpAbs"
      ]
  );

  Set<String> selectedBodyParts = {};

  bool iconController = false;
  void _toggleIcon(){
    setState(() {
      iconController = !iconController;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ContainerBody(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                      opacity: iconController ? 0.0 : 1.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: ImageProcessor(selectedBodyParts: selectedBodyParts),
                      )
                  ),
                  Opacity(
                      opacity: iconController ? 1.0 : 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: const ImageAdder(),
                      )
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    _toggleIcon();
                  },
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(onPressed: (){
                    _toggleIcon();
                  },
                      icon: const Icon(Icons.arrow_forward_ios)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedBodyParts.contains(bodyPartsList[index]) ?
                            selectedBodyParts.remove(bodyPartsList[index]) :
                            selectedBodyParts.add(bodyPartsList[index]);
                          });
                        },
                        child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                alignment: Alignment.center,
                                height: 60.0,
                                width: 60.0,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amberAccent
                                ),
                                child: const Icon(Icons.adb),
                              ),
                              Container(
                                width: 60,
                                child: Text(
                                  bodyPartsList[index],
                                  style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemCount: bodyPartsList.length
                ),
              ),

            ],
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          widget.allExercisesBloc.add(AddExercise(Exercise(
            id: '',
            adding_user_id: user.name!,
            body_parts: selectedBodyParts.toList(),
            description: '',
            name: '',
            photo_url: '',
            veryfied: false
          )));

          Navigator.pop(context);
        },
        shape: const CircleBorder(),
          child: const Icon(Icons.add),
      ),
    );
  }
}