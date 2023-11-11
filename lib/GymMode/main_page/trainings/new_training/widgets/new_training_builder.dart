import 'package:exercise_repository/exercise_repository.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';
import 'package:flutter/material.dart';

class NewTrainingBuilder extends StatefulWidget {
  const NewTrainingBuilder({super.key, required this.allExercises});
  final List<Exercise>? allExercises;

  @override
  State<NewTrainingBuilder> createState() => NewTrainingBuilderState();
}

class NewTrainingBuilderState extends State<NewTrainingBuilder> {

  @override
  void initState() {
    items = widget.allExercises!;
    super.initState();
  }

  TextEditingController editingController = TextEditingController();
  bool showOnlyVerified = false;
  List<int> selectedIndexes = [];
  final GlobalKey draggableKey = GlobalKey();
  List<Exercise> exercisesToAdd = [];
  List<Exercise> items = [];


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
      appBar: AppBar(
        title: const Text('Add Exercises'),
      ),
      body: Container(
        child: Column(
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
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 12,),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(items[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        selectedTileColor: Colors.green,
                        selected: selectedIndexes.contains(index),
                        splashColor: Colors.green,
                        onTap: (){
                          setState(() {
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);
                            } else {
                              selectedIndexes.add(index);
                            }
                          });

                          if (selectedIndexes.contains(index)) {
                            exercisesToAdd.add(items[index]);
                          } else {
                            exercisesToAdd.remove(items[index]);
                          }
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
      ),
      drawer: Drawer(
        child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .1),
              const Text("Show only verified"),
              Switch(
                  value: showOnlyVerified,
                  activeColor: Colors.red,
                  onChanged: (bool value){
                    setState(() {
                      showOnlyVerified = value;

                      showOnlyVerified ? items = widget.allExercises!.where((item) => item.veryfied).toList() :
                      items = widget.allExercises!;
                    });
                  }
              ),
            ]
        ),
      ),
      floatingActionButton: FabCircularMenu(
        children: <Widget>[
          Tooltip(
            message: "Abandon",
            child: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: (){
                Navigator.pop(context);
              }
              ,),
          ),
          Tooltip(
            message: "Add these exercises",
            child: IconButton(icon: const Icon(Icons.save_outlined),
              onPressed: (){
                Navigator.pop(context, exercisesToAdd);
              }
              ,),
          ),
        ],
      ),
    );
  }
}