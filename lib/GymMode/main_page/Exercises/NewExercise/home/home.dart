import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../authorization/app/app.dart';
import '../../Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import '../../Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import '../widgets/widgets.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({super.key, required this.allExercisesBloc, required this.exercisesByCategoryBloc});
  final AllExercisesBloc allExercisesBloc;
  final ExercisesByCategoryBloc exercisesByCategoryBloc;

  @override
  State<NewExercise> createState() => _NewExerciseState();
}


class _NewExerciseState extends State<NewExercise> {
  static const mainColor = Color.fromARGB(255, 105, 70, 70);

  final List<String> bodyPartsList = List.of(
      [
        "Adductor", "Biceps", "Butt", "Calf", "Chest", "CoreAbs", "Deltoid", "Dorsi", "DownAbs", "Femoris",
        "Forearm", "Quadriceps", "Rest", "Shoulders", "SideAbs", "Trapezius", "Triceps", "UpAbs"
      ]
  );

  @override
  initState(){
    bodyPartClicked = List.generate(bodyPartsList.length, (index) => false);
    super.initState();
  }

  Set<String> selectedBodyParts = {};
  List<bool> bodyPartClicked = [];
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
      backgroundColor: mainColor,

      body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderTitle(
              onRefreshTap: () {
                setState(() {
                  selectedBodyParts.clear();
                  photoUrl = "";
                  exerciseName = "";
                  exerciseDescription = "";
                });
              },
            ),
            const SizedBox(height: 10,),
            ContainerBody(
              children: [
                InkWell(
                  onTap: (){
                    selectedBodyParts.isEmpty
                        ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          title: Text("You are trying to add exercise without body parts!", style: Theme.of(context).textTheme.titleLarge,),
                          content: Text("At least one body part must be selected", style: Theme.of(context).textTheme.titleMedium,),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  backgroundColor: Colors.red
                              ),
                              child: const Text("Go back"),
                            ),
                          ],
                        );
                      }
                    ) : {
                      widget.allExercisesBloc.add(AddExercise(exercise: Exercise(
                      id: '',
                      adding_user_id: user.id,
                      body_parts: selectedBodyParts.toList(),
                      description: exerciseDescription,
                      name: exerciseName.isEmpty ? "Exercise${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" :exerciseName,
                      photo_url: photoUrl,
                      verified: false,
                          adding_user_name: user.name == null ? user.email!.split('@').first : user.name!
                      ))),

                      widget.allExercisesBloc.add(RefreshExercises()),
                      widget.exercisesByCategoryBloc.add(RefreshExercisesByCategory()),
                      Navigator.pop(context),
                    };
                  },
                  child: const Tooltip(
                      message: "Save",
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(Icons.add_task_rounded, size: 100, color: mainColor),
                      )
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text("Exercise Name", style: Theme.of(context).textTheme.titleLarge, ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: exerciseName.isEmpty ? "Exercise${"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"}" : exerciseName,
                    hintMaxLines: 15,
                    hintStyle: Theme.of(context).textTheme.titleLarge,
                    prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
                      color: mainColor,
                      shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
                    )), border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (text) {
                    setState(() {
                      exerciseName = text;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text("Description", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.titleMedium,
                    prefixIcon: Transform.rotate(angle: 270 * 3.1416 /180, child: const Icon(Icons.edit_rounded,
                      color: mainColor,
                      shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
                    )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (text) {
                    setState(() {
                      exerciseDescription = text;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  child: Text("Exercise images", style: Theme.of(context).textTheme.titleLarge, ),
                ),
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
                Container(
                  alignment: Alignment.center,
                  child: Text("Body parts", style: Theme.of(context).textTheme.titleLarge, ),
                ),
                const SizedBox(height: 20,),
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

                              bodyPartClicked[index] = !bodyPartClicked[index];
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
                                      color: Color.fromARGB(0, 0, 0, 0)
                                  ),
                                  child: bodyPartClicked[index]
                                      ? const Icon(Icons.check_circle, color: mainColor, size: 40,)
                                      : const Icon(Icons.radio_button_unchecked_outlined),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    bodyPartsList[index],
                                    style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
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
      ),
    );
  }
}