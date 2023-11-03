import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../authorization/app/app.dart';
import '../../ExerciseDescription/widgets/container_body.dart';
import '../../Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import '../../Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import '../widgets/new_exercise_images.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({super.key, required this.allExercisesBloc, required this.exercisesByCategoryBloc});
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;

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
  String photoUrl = "";
  String exerciseName = "";
  String exerciseDescription = "";

  void handleUrlChanged(String url) {
    setState(() {
      photoUrl = url;
    });
  }

  bool iconController = false;
  void _toggleIcon(){
    setState(() {
      iconController = !iconController;
    });
  }

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
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
              Text("Exercise Images: ", style: Theme.of(context).textTheme.headlineSmall,),
              NewExerciseImages(selectedBodyParts: selectedBodyParts, handleUrlChanged: handleUrlChanged, iconController: iconController,),
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
              Text("Body Parts:", style: Theme.of(context).textTheme.headlineSmall,),
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
              Text("Exercise Name:", style: Theme.of(context).textTheme.headlineSmall,),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController1,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    onChanged: (text){

                      setState(() {
                        exerciseName = text;
                      });
                    },
                  )
              ),
              Text("Exercise Description:", style: Theme.of(context).textTheme.headlineSmall,),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 3,
                    controller: _textController2,
                    maxLength: 200,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    onChanged: (text){
                      text.isEmpty ?

                      setState(() {
                        exerciseDescription = "Exercise has no description";
                      }) :

                      setState(() {
                        exerciseDescription = text;
                      });
                    },
                  )
              )
            ],
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          widget.allExercisesBloc.add(AddExercise(exercise: Exercise(
            id: '',
            adding_user_id: user.name!,
            body_parts: selectedBodyParts.toList(),
            description: exerciseDescription,
            name: exerciseName.isEmpty ? "Exercise${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" :exerciseName,
            photo_url: photoUrl,
            veryfied: false
          )));

          widget.allExercisesBloc.add(RefreshExercises());
          widget.exercisesByCategoryBloc.add(RefreshExercisesByCategory());
          Navigator.pop(context);
        },
        shape: const CircleBorder(),
          child: const Icon(Icons.add),
      ),
    );
  }
}