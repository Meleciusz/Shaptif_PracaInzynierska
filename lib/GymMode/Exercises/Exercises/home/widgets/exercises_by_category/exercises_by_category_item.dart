import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:shaptifii/GymMode/Exercises/ExerciseDescription/exercises_description.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/exercises_by_category_title.dart';

class ExerciseByCategoryItem extends StatefulWidget {
  const ExerciseByCategoryItem(
      {super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseByCategoryItem> createState() => _ExerciseByCategoryItemState();
}
class _ExerciseByCategoryItemState extends State<ExerciseByCategoryItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ExerciseDescription(exercise: widget.exercise)
            )
        );
      },
      child: Stack(
          children: [
            FutureBuilder(
                future: _checkInternetConnection(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data == true){
                      return Container(
                        width: 270.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          image: DecorationImage(
                            image:  NetworkImage(widget.exercise.photo_url),
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.black45,
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      );
                    }
                    else{
                      return const Icon(Icons.image_not_supported_rounded, size: 190.0);
                    }
                  }
                  else{
                    return const CircularProgressIndicator();
                  }
                }
            ),

            Positioned(
              bottom: 18.0,
              child: ExercisesByCategoryTitle(
                name: widget.exercise.name,
              ),
            ),
          ]
      ),
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