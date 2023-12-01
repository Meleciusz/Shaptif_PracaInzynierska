import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';

/*
 *Main description:
This class describes new training builder - screen for creating new training by adding exercises that are on this screen
 */
class NewTrainingBuilder extends StatefulWidget {
  const NewTrainingBuilder({super.key, required this.allExercises});

  //list of exercises
  final List<Exercise>? allExercises;

  @override
  State<NewTrainingBuilder> createState() => NewTrainingBuilderState();
}

class NewTrainingBuilderState extends State<NewTrainingBuilder> {

  @override
  void initState() {

    //fill items with all exercises list
    items = widget.allExercises!;
    super.initState();
  }

  //text editing controller
  TextEditingController editingController = TextEditingController();

  //showOnlyVerified flag(set by user when switching in drawer)
  bool showOnlyVerified = false;

  //selected indexes by user list
  List<int> selectedIndexes = [];

  //key for draggable list
  final GlobalKey draggableKey = GlobalKey();

  //list of exercises to add to training
  List<Exercise> exercisesToAdd = [];

  //list of filtered exercises
  List<Exercise> items = [];


  //filter search results
  void filterSearchResults(value) {
    setState(() {
      items = widget.allExercises!
          .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: "Open drawer",
                        child: IconButton(
                          onPressed: (){
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Transform.rotate(
                            angle: 270 * 3.1416 / 180,
                            child: const Icon(Icons.drag_indicator, size: 40),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Center(
                            child: Text("Select exercises", style: TextStyle(
                              color: Color.fromARGB(255, 72, 72, 77),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ), overflow: TextOverflow.ellipsis,),
                          )
                      ),
                      exercisesToAdd.isEmpty ?
                      Tooltip(
                        message: "Go back",
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Transform.rotate(
                            angle: 180 * 3.1416 / 180,
                            child: const Icon(Icons.exit_to_app, size: 40),
                          ),
                        ),
                      ) :
                      Tooltip(
                          message: "Save",
                          child: IconButton(
                            onPressed: (){
                              Navigator.pop(context, exercisesToAdd);
                            },
                            icon: Transform.rotate(
                              angle: 0 * 3.1416 / 180,
                              child: const Icon(Icons.save_rounded, size: 40,),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                ContainerBody(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value){
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: const InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular((25.0)))
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: items.length * 70 + 70,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(height: 12,),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                title: Text(
                                  items[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                trailing: exercisesToAdd.contains(items[index]) ? const Icon(Icons.check_circle, color: Colors.lightGreen,) : const Icon(Icons.radio_button_unchecked_rounded),
                                selected: exercisesToAdd.contains(items[index]), //selectedIndexes.contains(index),
                                onTap: (){

                                  setState(() {
                                    if (exercisesToAdd.contains(items[index])) {
                                      exercisesToAdd.remove(items[index]);
                                    } else {
                                      exercisesToAdd.add(items[index]);
                                    }
                                  });

                                },
                                onLongPress: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        title: Text(items[index].name),
                                        content: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: "Used body parts",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " ${items[index].body_parts.join(', ')}\n\n ",
                                              ),
                                              const TextSpan(
                                                text: "Description: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " ${items[index].description}",
                                              ),
                                            ],
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),

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
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                        ),
                      ),
                    ]
                ),

              ]
          );
        },
      ),
      drawer: Drawer(
        child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              Text("Settings", style: Theme.of(context).textTheme.displayMedium, overflow: TextOverflow.ellipsis,),
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              Text("Show only verified", style: Theme.of(context).textTheme.titleLarge),
              Switch(
                  value: showOnlyVerified,
                  activeColor: Colors.red,
                  onChanged: (bool value){
                    setState(() {
                      showOnlyVerified = value;

                      showOnlyVerified ? items = widget.allExercises!.where((item) => item.verified).toList() :
                      items = widget.allExercises!;
                    });
                  }
              ),
            ]
        ),
      ),
    );
  }
}