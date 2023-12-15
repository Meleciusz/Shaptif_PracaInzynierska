import 'package:flutter/material.dart';
import 'package:container_body/container_body.dart';
import '../widgets/widgets.dart';

/*
 * Main description:
 This class describes what is displayed on the training qa screen
 */

class TrainingInstructionsHome extends StatelessWidget {
  const TrainingInstructionsHome({Key? key}) : super(key: key);
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
            const HeaderTitle(title: "QA Trainings",),
            const SizedBox(height: 20),
            ContainerBody(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                          children: [
                            const Icon(Icons.question_answer_rounded, size: 80.0),
                            Text(
                              "Trainings Instructions",
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
                  Text("Trainings are connected with user, so only you can see yours trainings. "
                    , style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 6.0),
                  Text("Trainings mode allow you to :", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  1. Add training", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  2. Delete training(only if you are the author of this exercise)", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  3. Have a look at every training description", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  4. Have a look at trainings history", style: Theme.of(context).textTheme.titleMedium,),
                  Text("  5. Play trainings", style: Theme.of(context).textTheme.titleMedium,),
                  const SizedBox(height: 6.0),
                  Text("If you don't know what to do, every clickable icon and element can be long press for more details ", style: Theme.of(context).textTheme.titleMedium,),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Go back",
                        child: Icon(Icons.transit_enterexit_rounded, size: 40.0),
                      ),
                      Tooltip(
                        message: "Icon is touchable",
                        child: Icon(Icons.touch_app_sharp, size: 40.0),
                      ),
                      Tooltip(
                        message: "Delete element",
                        child: Icon(Icons.remove, size: 40.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Switch between trainings and exercises",
                        child: Icon(Icons.switch_right_rounded, size: 40.0),
                      ),
                      Tooltip(
                        message: "Add element",
                        child: Icon(Icons.add, size: 40.0),
                      ),
                      Tooltip(
                        message: "Refresh elements",
                        child: Icon(Icons.refresh, size: 40.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Check trainings history",
                        child: Icon(Icons.auto_stories_rounded, size: 40.0),
                      ),
                      Tooltip(
                        message: "Save and quit training",
                        child: Icon(Icons.stop_circle_outlined, size: 40.0),
                      ),
                      Tooltip(
                        message: "Mark exercise as finished",
                        child: Icon(Icons.lock, size: 40.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Start training",
                        child: Icon(Icons.play_arrow_outlined, size: 40.0),
                      ),
                      Tooltip(
                        message: "Fast forward",
                        child: Icon(Icons.keyboard_double_arrow_right_sharp, size: 40.0),
                      ),
                      Tooltip(
                        message: "End training",
                        child: Icon(Icons.stop_outlined, size: 40.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Check trainings history",
                        child: Icon(Icons.save, size: 40.0),
                      ),
                      Tooltip(
                        message: "Show drawer menu",
                        child: Icon(Icons.drag_indicator, size: 40.0),
                      ),
                      Tooltip(
                        message: "Start quick training(Without creating a new training)",
                        child: Icon(Icons.local_fire_department_outlined, size: 40.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
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
                  Image.asset("images/Instructions/circular_menu_trainings.png",),
                  const SizedBox(height: 10,),
                  Text("  2. Search Bar", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Allow you to search exercise by name)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/search_bar.png",),
                  const SizedBox(height: 10,),
                  Text("  3. Body parts picker", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Allow you to search exercise by body part)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/trainings_parts.png",),
                  const SizedBox(height: 10,),
                  Text("  4. Trainings player", style: Theme.of(context).textTheme.titleMedium,),
                  Text("(Allow you to start training)", style: Theme.of(context).textTheme.titleMedium,),
                  Image.asset("images/Instructions/trainings_play.png",),
                  const SizedBox(height: 10,),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
