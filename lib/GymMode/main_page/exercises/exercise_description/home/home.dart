import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import '../../exercises/home/widgets/all_exercises_widget/all_exercises.dart';
import '../../exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import '../widgets/image_manager.dart';
import 'widgets/widgets.dart';

/*
 * Main description:
This is layout
This class define what is displayed on screen

* Main elements:
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
ContainerBody - Custom container to display Widgets
 */
class ExerciseDescription extends StatefulWidget {
  const ExerciseDescription({super.key, required this.exercise, required this.allExercisesBloc, required this.exercisesByCategoryBloc});
  final Exercise exercise;
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;

  @override
  State<ExerciseDescription> createState() => _ExerciseDescriptionState();
}

 class _ExerciseDescriptionState extends State<ExerciseDescription>{

  //iconController is used for image animation change
  bool iconController = false;
   void _toggleIcon(){
     setState(() {
       iconController = !iconController;
     });
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 64, 64),
        body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderTitle(verified: widget.exercise.verified, addingUserID: widget.exercise.adding_user_id,
                  exerciseId: widget.exercise.id, allExercisesBloc: widget.allExercisesBloc,
                  exercisesByCategoryBloc: widget.exercisesByCategoryBloc, photoUrl: widget.exercise.photo_url
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

                  //display exercise images
                  Stack(
                    alignment: Alignment.center,
                    children: [

                      //display exercise image based on internet connection
                      FutureBuilder<bool>(
                        future: _checkInternetConnection(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.data == true) {

                              //show image from database if opacity is selected
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
                                    shape: BoxShape.circle,
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

                              //show that image is not available
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

                      //show image from image manager if opacity is selected
                      Opacity(
                        opacity: iconController ? 0.0 : 1.0,
                        child:  SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: ImageProcessor(exercise: widget.exercise),
                        ),
                      ),
                    ],
                  ),

                  //change image that is displayed
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
                  Text("Body parts used in exercise:", style: Theme.of(context).textTheme.headlineSmall,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.exercise.body_parts!.map((part) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("- $part",
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  Text("Note:", style: Theme.of(context).textTheme.headlineSmall,),
                  Text(widget.exercise.description ?? '', style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
            ]
        ),
      )
    );
  }
}

//function to check internet connection
Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}