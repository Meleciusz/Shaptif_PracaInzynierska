import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import 'package:training_repository/training_repository.dart';

import 'training_player/home.dart';

class TrainingPlayBoard extends StatelessWidget {
  const TrainingPlayBoard({super.key, required this.trainings, required this.mode});
  final List<Training> trainings;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: (120 * trainings.length).toDouble() + 20 * (trainings.length + 1),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        title: Text("Exercises:\n  ${trainings[index].exercises.join("\n  ")}", overflow: TextOverflow.ellipsis,),
                        content: SizedBox(
                          height: 300.0,
                          child: Column(
                            children: [
                              Expanded(
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: List.generate(
                                      trainings[index].isFinished.length,
                                          (i) => PieChartSectionData(
                                        color: trainings[index].isFinished[i] ? Colors.green : Colors.red,
                                        radius: 30,
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("Finished: ${trainings[index].isFinished.where((element) => element == true).length}/${trainings[index].isFinished.length}"),
                            ],
                          ),
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
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(.1),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            getColor(mode).withOpacity(1),
                            getColor(mode).withOpacity(0.5),
                          ]
                      )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 25.0,
                          left: 20.0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(
                              trainings[index].name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                      ),
                      Positioned(
                          top: 35.0,
                          left: MediaQuery.of(context).size.width * .70,
                          child: SizedBox(
                            child: mode=="Ended"
                                ? Tooltip(
                              message: "Refresh",
                              child: IconButton(onPressed: (){}, icon: const Icon(Icons.refresh, size: 35, color: Color.fromARGB(
                                  255, 166, 123, 18)))
                            ) : Tooltip(
                              message: "Start",
                              child: IconButton(onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TrainingPlayer(exercises: trainings[index].exercises,)
                                    )
                                );
                              }, icon: const Icon(Icons.play_arrow_outlined, size: 35, color: Color.fromARGB(
                                  255, 70, 136, 5),)),
                            ),

                          )
                      ),
                      mode == "Progress" ? Positioned(
                          top: 70.0,
                          left: MediaQuery.of(context).size.width * .71,
                          child: SizedBox(
                            child: Tooltip(
                              message: "Skip",
                              child: IconButton(onPressed: (){
                                context.read<TrainingPlayBloc>().add(UpdateTrainingStatus(training: Training(
                                    id: trainings[index].id,
                                    isFinished: trainings[index].isFinished.map((e) => e = true).toList(),
                                    name: trainings[index].name,
                                    exercises: trainings[index].exercises,
                                    startingWeight: trainings[index].startingWeight,
                                    addingUserId: trainings[index].addingUserId,
                                    allBodyParts: trainings[index].allBodyParts,
                                    addingUserName: trainings[index].addingUserName,
                                    description: trainings[index].description,
                                    mainlyUsedBodyPart: trainings[index].mainlyUsedBodyPart,
                                    verified: trainings[index].verified
                                )));
                                context.read<TrainingPlayBloc>().add(RefreshPlayTrainings());
                              }, icon: const Icon(Icons.keyboard_double_arrow_right_sharp, size: 30,)),
                            ),)
                      ) : const SizedBox(),
                      mode == "Progress" ? Positioned(
                          top: 0.0,
                          left: MediaQuery.of(context).size.width * .71,
                          child: SizedBox(
                            child: Tooltip(
                              message: "Abandon",
                              child: IconButton(onPressed: (){
                                context.read<TrainingPlayBloc>().add(UpdateTrainingStatus(training: Training(
                                    id: trainings[index].id,
                                    isFinished: trainings[index].isFinished.map((e) => e = false).toList(),
                                    name: trainings[index].name,
                                    exercises: trainings[index].exercises,
                                    startingWeight: trainings[index].startingWeight,
                                    addingUserId: trainings[index].addingUserId,
                                    allBodyParts: trainings[index].allBodyParts,
                                    addingUserName: trainings[index].addingUserName,
                                    description: trainings[index].description,
                                    mainlyUsedBodyPart: trainings[index].mainlyUsedBodyPart,
                                    verified: trainings[index].verified
                                )));
                                context.read<TrainingPlayBloc>().add(RefreshPlayTrainings());
                              }, icon: const Icon(Icons.stop_outlined, size: 30, color: Color.fromARGB(
                                  255, 192, 70, 70),)),),
                          )
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: trainings.length,
          ),
        ),
      ],
    );
  }
}

Color getColor(String mode) {
  switch (mode) {
    case "Progress":
      return Colors.orange;
    case "Ended":
      return Colors.green;
    default:
      return Colors.grey;
  }
}