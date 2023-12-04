import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../authorization/app/app.dart';
import '../../exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import '../../exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import '../widgets/widgets.dart';


/*
 * Main description:
This is layout
This class define what is displayed on screen

* Main elements:
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
ContainerBody - Custom container to display Widgets
 */
class NewExercise extends StatefulWidget {
  NewExercise({super.key, required this.allExercisesBloc,
    required this.exercisesByCategoryBloc, required this.bodyParts}):
        bodyPartsNames = bodyParts.map((e) => e.part).toList();

  //all exercise bloc context
  final AllExercisesBloc allExercisesBloc;

  //exercises by category bloc context
  final ExercisesByCategoryBloc exercisesByCategoryBloc;

  //list of body parts
  final List<BodyParts> bodyParts;

  //list of body parts
  final List<String> bodyPartsNames;

  @override
  State<NewExercise> createState() => _NewExerciseState();
}


class _NewExerciseState extends State<NewExercise> {
  static const mainColor = Color.fromARGB(255, 105, 70, 70);


  @override
  initState(){

    //bodyPartClicked is list that contains information about which body part button was clicked
    bodyPartClicked = List.generate(widget.bodyPartsNames.length, (index) => false);
    super.initState();
  }

  //set of selected body parts by user
  Set<String> selectedBodyParts = {};

  //list that contains information about which body part button was clicked
  List<bool> bodyPartClicked = [];

  //photo url
  String photoUrl = "";

  //exercise name
  String exerciseName = "";

  //exercise description
  String exerciseDescription = "";

  //function to set photo url from firebase storage after user take photo
  void handleUrlChanged(String url) {
    setState(() {
      photoUrl = url;
    });
  }

  //iconController is used for image animation change
  bool iconController = false;
  void _toggleIcon(){
    setState(() {
      iconController = !iconController;
    });
  }

  //text controllers
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  //dispose text controllers
  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    //get user from context
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 43.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderTitle(
              //refresh button(returns to default state)
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

              //button to save exercise
              SizedBox(
              height: 100,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                  Positioned(
                      width: MediaQuery.of(context).size.width * 0.7,
                      top: 40,
                      child: const Icon(Icons.touch_app_sharp, size: 30,)),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    child:InkWell(
                      onTap: (){
                        //check if user selected at least one body part(If not show alert)
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
                              adding_user_name: user.name != null && user.name!.isNotEmpty ? user.name! : (user.email != null ? user.email!.split('@').first : 'Unknown')
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
                    ),
                  ],
                  )
                ),
                const SizedBox(height: 20),

                //exercise name
                Container(
                  alignment: Alignment.center,
                  child: Text("Exercise Name", style: Theme.of(context).textTheme.titleLarge, ),
                ),

                //displays text field for exercise name
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

                //exercise description
                Container(
                  alignment: Alignment.center,
                  child: Text("Description", style: Theme.of(context).textTheme.titleLarge,),
                ),

                //displays text field for description
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

                //exercise images
                Container(
                  alignment: Alignment.center,
                  child: Text("Exercise images", style: Theme.of(context).textTheme.titleLarge, ),
                ),

                //images widget
                NewExerciseImages(selectedBodyParts: selectedBodyParts,
                  handleUrlChanged: handleUrlChanged, iconController: iconController,
                  bodyParts: widget.bodyParts,
                ),

                //buttons to change image
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

                //body parts
                Container(
                  alignment: Alignment.center,
                  child: Text("Body parts", style: Theme.of(context).textTheme.titleLarge, ),
                ),
                const SizedBox(height: 20,),

                //body parts list to select
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedBodyParts.contains(widget.bodyPartsNames[index]) ?
                              selectedBodyParts.remove(widget.bodyPartsNames[index]) :
                              selectedBodyParts.add(widget.bodyPartsNames[index]);

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
                                    widget.bodyPartsNames[index],
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
                      itemCount: widget.bodyPartsNames.length
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