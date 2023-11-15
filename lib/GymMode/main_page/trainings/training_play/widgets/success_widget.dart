import 'package:container_body/container_body.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../new_training/home/home.dart';
import '../../trainings/home/widgets/all_trainings_widget/bloc/all_trainings_widget_bloc.dart';
import '../bloc/training_play_bloc.dart';
import 'board.dart';
import 'header_tile.dart';
import 'training_player/home.dart';

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
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (context) => TrainingPlayer(
                //       exercises: [],
                //       allExercises: widget.allExercises!,
                //       callbackExercise: (List<String> newExercises) {  //TODO check if it works
                //         // Navigator.of(context).push(
                //         //     MaterialPageRoute(
                //         //         builder: (context) => const NewTrainingPage()
                //         //     )
                //         // ).whenComplete(() {
                //         //   context.read<AllTrainingsBloc>().add(RefreshTrainings());
                //         // });
                //         // Navigator.of(context).pop();
                //         // Navigator.of(context).pop();
                //       },
                //     )
                //     )
                // );
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