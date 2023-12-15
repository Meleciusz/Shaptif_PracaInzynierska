import 'package:flutter/material.dart';
import 'package:container_body/container_body.dart';
import '../widgets/widgets.dart';

/*
 * Main description:
 This class describes what is displayed on the exercise qa screen
 */

class ExerciseInstructionsHome extends StatelessWidget {
  const ExerciseInstructionsHome({Key? key}) : super(key: key);
  static const mainColor = Color.fromARGB(255, 92, 96, 95);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderTitle(title: "QA Exercises",),
            const SizedBox(height: 20),
            Expanded(
              child: ContainerBody(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Icon(Icons.question_answer_rounded, size: 80.0),
                        Text(
                          "Exercises Instructions",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10.0),
                      ]
                    )
                  ),
                  const SizedBox(height: 10.0),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "1. ",
                            style: Theme.of(context).textTheme.displayMedium
                        ),
                        TextSpan(
                          text: "Start",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Text("Every exercise is shared between all users, you have access to every added exercise. "
                      , style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 6.0),
                  Text("Exercise mode allow you to :", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  1. Add exercise", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  2. Delete exercise(only if you are the author of this exercise)", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  3. Have a look at every exercise description", style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 6.0),
                  Text("If you don't know what to do, every clickable icon can be long press for details ", style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 20,),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "2. ",
                            style: Theme.of(context).textTheme.displayMedium
                        ),
                        TextSpan(
                          text: "Icons meaning",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 10.0),
                  Text("(Long press on Icon to see more details)", style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        const Positioned(
                          left: 0,
                            child: Tooltip(
                              message: "Go back",
                              child: Icon(Icons.transit_enterexit_rounded, size: 40.0),
                            )
                        ),Positioned(
                          left: MediaQuery.of(context).size.width * 0.4,
                            child: const Tooltip(
                              message: "Icon is touchable",
                              child: Icon(Icons.touch_app_sharp, size: 40.0),
                            )
                        ),Positioned(
                          left: MediaQuery.of(context).size.width * 0.8,
                            child: const Tooltip(
                              message: "Delete element",
                              child: Icon(Icons.delete_forever, size: 40.0),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        const Positioned(
                            left: 0,
                            child: Tooltip(
                              message: "Switch between trainings and exercises",
                              child: Icon(Icons.switch_right_rounded, size: 40.0),
                            )
                        ),Positioned(
                            left: MediaQuery.of(context).size.width * 0.4,
                            child: const Tooltip(
                              message: "Add element",
                              child: Icon(Icons.add, size: 40.0),
                            )
                        ),Positioned(
                            left: MediaQuery.of(context).size.width * 0.8,
                            child: const Tooltip(
                              message: "Refresh elements",
                              child: Icon(Icons.refresh, size: 40.0),
                            )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "3. ",
                            style: Theme.of(context).textTheme.displayMedium
                        ),
                        TextSpan(
                          text: "Functionalities",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 10.0),
                  Text("  1. Circular menu", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Menu allow you to access more functionalities)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/button_clicked.png",),
                  const SizedBox(height: 10,),
                  Text("  2. Search Bar", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Allow you to search exercise by name)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/search_bar.png",),
                  const SizedBox(height: 10,),
                  Text("  3. Body parts picker", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Allow you to search exercise by body part)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/categories.png",),
                  const SizedBox(height: 10,),
                  Text("  4. Categorized exercise", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Show name and image of exercise)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/exercise_element_big.png",),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
