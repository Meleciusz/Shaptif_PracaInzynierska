import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../authorization/app/app.dart';
import '../../../../Exercises/home/widgets/all_exercises_widget/all_exercises.dart';
import '../../../../Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';


class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.verified, required this.addingUserID,
    required this.exerciseId, required this.allExercisesBloc, required this.exercisesByCategoryBloc,
    required this.photoUrl,
  });
  final bool verified;
  final String addingUserID;
  final String exerciseId;
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;
  final String photoUrl;



  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        user.id == addingUserID ?
        verified ? IconButton(onPressed: (){}, icon: const Icon(Icons.add), color: const Color.fromARGB(0, 0, 0, 0),) :
        Tooltip(
          message: "Delete exercise",
          child: IconButton(onPressed: (){
            allExercisesBloc.add(DeleteExercise(exerciseID: exerciseId));
            allExercisesBloc.add(RefreshExercises());
            exercisesByCategoryBloc.add(RefreshExercisesByCategory());

            Reference storageReference = FirebaseStorage.instance.refFromURL(photoUrl);
            try {
              storageReference.delete();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }

            Navigator.pop(context);
          }, icon: const Icon(Icons.delete_forever, size: 40)),
        ) : IconButton(onPressed: (){}, icon: const Icon(Icons.add), color: const Color.fromARGB(0, 0, 0, 0),),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Description", style: TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ), overflow: TextOverflow.ellipsis,),
            )
        ),
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.transit_enterexit_rounded, size: 40),
          ),
        ),
      ],
    );
  }
}