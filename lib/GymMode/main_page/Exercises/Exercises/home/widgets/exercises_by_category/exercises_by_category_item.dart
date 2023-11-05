import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/ExerciseDescription/exercises_description.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import 'package:shaptifii/GymMode/main_page/Exercises/Exercises/home/widgets/exercises_by_category/exercises_by_category_title.dart';

import '../all_exercises_widget/bloc/all_exercises_bloc.dart';

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
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    final ExercisesByCategoryBloc exercisesByCategoryBloc = BlocProvider.of<ExercisesByCategoryBloc>(context);

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ExerciseDescription(exercise: widget.exercise, allExercisesBloc: allExercisesBloc,
                  exercisesByCategoryBloc: exercisesByCategoryBloc)
            )
        );
      },
      child: Stack(
          children: [
            FutureBuilder(
                future: _checkInternetConnection(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.data == true && widget.exercise.photo_url != ""){
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
                    } else{
                      return Container(
                        width: 270.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.0,
                          )
                        ),
                        child: const Icon(Icons.image_not_supported_rounded, size: 150.0),
                      );
                    }
                  }
                  else{
                    return const CircularProgressIndicator();
                  }
                }
            ),

            Positioned(
              bottom: 0.0,
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