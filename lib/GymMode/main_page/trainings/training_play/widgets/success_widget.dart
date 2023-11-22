import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_repository/history_repository.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../new_training/home/home.dart';
import '../../trainings/home/widgets/all_trainings_widget/bloc/all_trainings_widget_bloc.dart';
import '../bloc/training_play_bloc.dart';
import 'board.dart';
import 'header_tile.dart';
import 'training_player/home.dart';
import 'training_player/return.dart';

class TrainingPlaySuccess extends StatefulWidget {
  const TrainingPlaySuccess(
      {super.key, required this.allTrainings, required this.allExercises});

  final List<Training>? allTrainings;
  final List<Exercise>? allExercises;

  @override
  State<TrainingPlaySuccess> createState() => _TrainingPlaySuccessState();
}

class _TrainingPlaySuccessState extends State<TrainingPlaySuccess> {
  TextEditingController editingController = TextEditingController();
  static const mainColor = Color.fromARGB(255, 164, 141, 204);

  @override
  initState() {
    items = widget.allTrainings!;
    super.initState();
  }

  void filterSearchResults(value) {
    setState(() {
      items = widget.allTrainings!
          .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  List<Training> items = <Training>[];

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
              onQuickStartTap: (){

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainingPlayer(
                      returnValues:
                      Return(
                        mainlyUsedBodyPart: "",
                        allBodyParts: [],
                        exercisesNames: [],
                        isFinished: [],
                        exercisesSetsCount: [],
                        exercisesWeights: [],
                        wantToSave: false,
                      ),
                      training: Training(
                        id: "",
                        name: "Quick training",
                        exercises: [],
                        addingUserId: user.id,
                        description: "",
                        mainlyUsedBodyPart: "",
                        verified: false,
                        allBodyParts: [],
                        isFinished: [],
                      ),
                      exercisesNames: [],
                      allExercises: widget.allExercises!,
                    )
                    )
                ).then((value){
                  if(value != null){
                    Return updatedValues = value;

                    updatedValues.exercisesSetsCount.every((element) => element == 0) ? null :
                    context.read<TrainingPlayBloc>().add(SaveAsHistoricalTraining(
                        history: History(
                          id: "",
                          name: "Quick training",
                          adding_user_id: user.id,
                          adding_user_name: user.name == null ? user.email!.split('@').first : user.name!,
                          exercises_name: updatedValues.exercisesNames,
                          exercises_sets_count: updatedValues.exercisesSetsCount,
                          exercises_weights: updatedValues.exercisesWeights,
                          date: Timestamp.now(),
                        ),
                        userID: user.id
                    ));
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ContainerBody(
              children: [
                const Icon(Icons.bar_chart_sharp,
                  size: 100,
                  shadows: <Shadow>[Shadow(color: mainColor, offset: Offset(-2, -2), blurRadius: 2,)],
                ),
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
                Container(
                  alignment: Alignment.center,
                  child: Text("Ended trainings", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(
                  trainings: items.where((element) => element.isFinished.every((e) => e == true)).toList(),
                  mode: "Ended",
                  exercises: widget.allExercises!,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Trainings in progress", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(
                  trainings: items.where((element) => element.isFinished.any((e) => e == true) && element.isFinished.any((e) => e == false)).toList(),
                  mode: "Progress",
                    exercises: widget.allExercises!,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Trainings to start", style: Theme.of(context).textTheme.titleLarge,),
                ),
                TrainingPlayBoard(
                  trainings: items.where((element) => element.isFinished.every((e) => e == false)).toList(),
                  mode: "Start",
                    exercises: widget.allExercises!,
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}