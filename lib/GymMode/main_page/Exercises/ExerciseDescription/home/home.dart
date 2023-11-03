import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import '../../Exercises/home/widgets/all_exercises_widget/all_exercises.dart';
import '../../Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import '../widgets/container_body.dart';
import '../widgets/image_manager.dart';
import 'widgets/widgets.dart';


class ExerciseDescription extends StatefulWidget {
  const ExerciseDescription({super.key, required this.exercise, required this.allExercisesBloc, required this.exercisesByCategoryBloc});
  final Exercise exercise;
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;

  @override
  State<ExerciseDescription> createState() => _ExerciseDescriptionState();
}

 class _ExerciseDescriptionState extends State<ExerciseDescription>{

  bool iconController = false;
   void _toggleIcon(){
     setState(() {
       iconController = !iconController;
     });
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderTitle(veryfied: widget.exercise.veryfied, addingUser: widget.exercise.adding_user_id,
                  exerciseId: widget.exercise.id, allExercisesBloc: widget.allExercisesBloc,
                  exercisesByCategoryBloc: widget.exercisesByCategoryBloc,
              ),
              const SizedBox(height: 20),

              ContainerBody(
                children: [
                  Center(
                    child: Text(widget.exercise.name ?? '',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                   const SizedBox(height: 20),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder<bool>(
                        future: _checkInternetConnection(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.data == true) {
                              return Opacity(
                                opacity: iconController ? 1.0 : 0.0,
                                child: widget.exercise.photo_url.isNotEmpty ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget.exercise.photo_url),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                ) : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.image_not_supported_rounded, size: 190.0),
                                    Text("Exercise has no image", style: Theme.of(context).textTheme.headlineSmall,)
                                  ]
                                )
                              );
                            } else {
                              return Opacity(
                                opacity: iconController ? 1.0 : 0.0,
                                child: const Icon(Icons.image_not_supported_rounded, size: 190.0),
                              );
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),

                      Opacity(
                        opacity: iconController ? 0.0 : 1.0,
                        child:  Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: ImageProcessor(exercise: widget.exercise),
                        ),
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
                  ],),
                  const SizedBox(height: 20),
                  Text("Mięsnie zaangażowane w ruch:", style: Theme.of(context).textTheme.headlineSmall,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.exercise.body_parts!.map((part) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("- " +
                          part,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  Text("Wykonanie:", style: Theme.of(context).textTheme.headlineSmall,),
                  Text(widget.exercise.description ?? '', style: Theme.of(context).textTheme.bodySmall,),
                ],
              ),
            ]
        ),
      )
    );
  }
}

Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}