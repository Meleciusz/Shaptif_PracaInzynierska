import 'dart:collection';
import 'dart:developer';

import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/new_training/bloc/new_training_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../../../authorization/app/bloc/app_bloc.dart';
import '../../trainings/home/widgets/all_trainings_widget/bloc/all_trainings_widget_bloc.dart';
import '../widgets/header_tile.dart';

class NewTrainingPage extends StatelessWidget {
  const NewTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => FirestoreExerciseService(),
          ),
          RepositoryProvider(
              create: (context) => FirestoreTrainingService(),
          ),
        ],
        child: BlocProvider<NewTrainingBloc>(
            create: (context) => NewTrainingBloc(
              trainingRepository: context.read<FirestoreTrainingService>(),
              exerciseRepository: context.read<FirestoreExerciseService>(),
            )..add(GetExercises()),
                child: const NewTrainingManager(),
        ),
    );
  }
}

class NewTrainingManager extends StatelessWidget {
  const NewTrainingManager({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTrainingBloc, NewTrainingState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? NewTrainingSuccess(allExercises: state.exercises)
            : state.status.isLoading
              ? const Center(child: CircularProgressIndicator(),)
              : state.status.isError
                ? const Center(child: Text('Error'),)
                : const SizedBox();
      }
    );
  }
}

class NewTrainingSuccess extends StatefulWidget {
  const NewTrainingSuccess({super.key, required this.allExercises});
  final List<Exercise>? allExercises;

  @override
  State<NewTrainingSuccess> createState() => NewTrainingSuccessState();
}

class NewTrainingSuccessState extends State<NewTrainingSuccess> {

  List<Exercise> exercises = <Exercise>[];
  String trainingName = '';
  String trainingDescription = '';
  List<int> startingWeights = <int>[];
  List<String> allBodyParts = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderTitle(),
            ContainerBody(
                children: [
                ]
            )
          ]
        ),
      ),
      floatingActionButton: FabCircularMenu(
        children: <Widget>[
          Tooltip(
            message: "Select exercises",
            child: IconButton(icon: const Icon(Icons.content_paste_search_rounded),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewTrainingBuilder(
                  allExercises: widget.allExercises,
                ))).then((value){
                  List<Exercise> chosenExercises = value;
                  setState(() {
                    exercises.addAll(chosenExercises);
                    chosenExercises.forEach((exercise) => allBodyParts.addAll(exercise.body_parts));
                    widget.allExercises!.removeWhere((element) => chosenExercises.contains(element));
                  });
                });
              }
              ,),
          ),
          Tooltip(
            message: "Save training",
            child: IconButton(icon: const Icon(Icons.save),
              onPressed: (){
                context.read<NewTrainingBloc>().add(AddNewTraining(training:
                Training(
                  name: trainingName,
                  description: trainingDescription,
                  exercises: exercises.map((e) => e.name).toList(),
                  startingWeight: startingWeights,
                  allBodyParts: allBodyParts.toSet().toList(),
                  addingUserName: context.read<AppBloc>().state.user.name!,
                  addingUserId: context.read<AppBloc>().state.user.id!,
                  id: "",
                  verified: false,
                  isFinished: List.generate(exercises.length, (index) => false),
                  mainlyUsedBodyPart: findMainlyUsedBodyPart(exercises, allBodyParts),
                )));
                //context.read<AllTrainingsBloc>().add(RefreshTrainings());
                Navigator.pop(context);
              },
            ),
          ),
          Tooltip(
            message: "Exit",
            child: IconButton(icon: const Icon(Icons.exit_to_app_sharp),
              onPressed: (){
                Navigator.pop(context);
              }
              ,),
          ),
        ]
      ),
    );
  }
}

String findMainlyUsedBodyPart(List<Exercise> exercises, List<String> allBodyParts) {
  var bodyPartCounts = <String, int>{};
  for (var bodyPart in allBodyParts) {
    bodyPartCounts[bodyPart] = (bodyPartCounts[bodyPart] ?? 0) + 1;
  }

  var mainlyUsedBodyPart = bodyPartCounts.entries.fold(
    bodyPartCounts.entries.first.key,
        (maxKey, entry) => entry.value > bodyPartCounts[maxKey]! ? entry.key : maxKey,
  );

  return mainlyUsedBodyPart;
}

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
                    title: Text(items[index].name),
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