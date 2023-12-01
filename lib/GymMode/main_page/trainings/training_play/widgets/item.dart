import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exercise_repository/exercise_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:history_repository/history_repository.dart';
import 'package:shaptifii/GymMode/main_page/trainings/training_play/bloc/training_play_bloc.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import 'package:training_repository/training_repository.dart';
import 'training_player/home.dart';
import 'training_player/return.dart';


/*
 * Main description:
This class describes item of training player
 */
class TrainingPlayBoard extends StatefulWidget {
  TrainingPlayBoard(
      {super.key, required this.trainings, required this.mode, required this.exercises}) :
        originalExercises = List.of(exercises); //initialize originalExercises

  //list of all trainings
  final List<Training> trainings;

  //mode of training(ended, in progress, finished)
  final String mode;

  //list of all exercises
  final List<Exercise> exercises;

  //list of original exercises
  final List<Exercise> originalExercises;

  @override
  State<TrainingPlayBoard> createState() => _TrainingPlayBoardState();
}

class _TrainingPlayBoardState extends State<TrainingPlayBoard> {

  @override
  Widget build(BuildContext context) {

    //get user from context
    final user = context.select((AppBloc bloc) => bloc.state.user);

    //if training list have no trainings
    return widget.trainings.isEmpty ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40,),
          Text("No trainings found ", style: Theme
              .of(context)
              .textTheme
              .titleMedium, overflow: TextOverflow.ellipsis,),
          const SizedBox(height: 40,),
        ]
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: (120 * widget.trainings.length).toDouble() +
              20 * (widget.trainings.length + 1),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 24.0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        title: Text(
                          "Exercises:\n  ${widget.trainings[index].exercises
                              .join("\n  ")}",
                          overflow: TextOverflow.ellipsis,),
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
                                      widget.trainings[index].isFinished.length,
                                          (i) =>
                                          PieChartSectionData(
                                            color: widget.trainings[index]
                                                .isFinished[i]
                                                ? Colors.green
                                                : Colors.red,
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
                              Text("Finished: ${widget.trainings[index]
                                  .isFinished
                                  .where((element) => element == true)
                                  .length}/${widget.trainings[index].isFinished
                                  .length}"),
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
                            getColor(widget.mode).withOpacity(1),
                            getColor(widget.mode).withOpacity(0.5),
                          ]
                      )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 25.0,
                          left: 20.0,
                          child: SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .6,
                            child: Text(
                              widget.trainings[index].name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge,
                            ),
                          )
                      ),
                      Positioned(
                          top: 35.0,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * .70,
                          child: SizedBox(
                            child: widget.mode == "Ended"
                                ? Tooltip(
                                message: "Refresh",
                                child: IconButton(onPressed: () {
                                  refreshTraining(index, user.id);
                                },
                                    icon: const Icon(Icons.refresh, size: 35,
                                        color: Color.fromARGB(
                                            255, 166, 123, 18)))
                                )
                             : FutureBuilder<bool>(
                                future: _checkInternetConnection(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.data == true) {
                                      return Tooltip(
                                        message: "Start",
                                        child: IconButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) =>
                                                  TrainingPlayer(
                                                    returnValues:
                                                    Return(
                                                      mainlyUsedBodyPart: widget
                                                          .trainings[index]
                                                          .mainlyUsedBodyPart,
                                                      allBodyParts: widget
                                                          .trainings[index].allBodyParts,
                                                      exercisesNames: widget
                                                          .trainings[index].exercises,
                                                      isFinished: widget.trainings[index]
                                                          .isFinished,
                                                      exercisesSetsCount: [],
                                                      exercisesWeights: [],
                                                      wantToSave: false,
                                                    ),
                                                    training: widget.trainings[index],
                                                    exercisesNames: widget
                                                        .trainings[index].exercises,
                                                    allExercises: widget.exercises,
                                                  )
                                              )
                                          ).then((value) {
                                            startTraining(value, user, index);
                                          });
                                        },
                                            icon: const Icon(
                                              Icons.play_arrow_outlined, size: 35,
                                              color: Color.fromARGB(
                                                  255, 70, 136, 5),)),
                                      );
                                    }
                                    return Tooltip(
                                      message: "Start training(history record will be saved after you'll connect to the Internet)",
                                      child: IconButton(onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>
                                                TrainingPlayer(
                                                  returnValues:
                                                  Return(
                                                    mainlyUsedBodyPart: widget
                                                        .trainings[index]
                                                        .mainlyUsedBodyPart,
                                                    allBodyParts: widget
                                                        .trainings[index].allBodyParts,
                                                    exercisesNames: widget
                                                        .trainings[index].exercises,
                                                    isFinished: List.generate(widget
                                                        .trainings[index].exercises.length, (index) => false),
                                                    exercisesSetsCount: [],
                                                    exercisesWeights: [],
                                                    wantToSave: false,
                                                  ),
                                                  training: widget.trainings[index],
                                                  exercisesNames: widget
                                                      .trainings[index].exercises,
                                                  allExercises: widget.exercises,
                                                )
                                            )
                                        ).then((value) {
                                          startTrainingWithoutInternet(value, user, index);
                                        });
                                      },
                                          icon: const Icon(
                                            Icons.play_arrow_outlined, size: 35,
                                            color: Color.fromARGB(
                                                255, 70, 70, 68),)),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }
                            )
                          )
                      ),
                      widget.mode == "Progress" ? Positioned(
                          top: 70.0,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * .71,
                          child: SizedBox(
                            child: Tooltip(
                              message: "Skip",
                              child: IconButton(onPressed: () {
                                skipTraining(index, user.id);
                              },
                                  icon: const Icon(
                                    Icons.keyboard_double_arrow_right_sharp,
                                    size: 30,)),
                            ),)
                      ) : const SizedBox(),
                      widget.mode == "Progress" ? Positioned(
                          top: 0.0,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * .71,
                          child: SizedBox(
                            child: Tooltip(
                              message: "Abandon",
                              child: IconButton(onPressed: () {
                                abandonTraining(index, user.id);
                              },
                                  icon: const Icon(
                                    Icons.stop_outlined, size: 30,
                                    color: Color.fromARGB(
                                        255, 192, 70, 70),)),),
                          )
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) =>
            const SizedBox(
              height: 20.0,
            ),
            itemCount: widget.trainings.length,
          ),
        ),
      ],
    );
  }

  //function to refresh training and update it to "to start" mode
  refreshTraining(int index, String userID){
    context.read<TrainingPlayBloc>().add(
        UpdateTrainingStatus(training: Training(
          id: widget.trainings[index].id,
          isFinished: widget.trainings[index]
              .isFinished.map((e) => e = false)
              .toList(),
          name: widget.trainings[index].name,
          exercises: widget.trainings[index]
              .exercises,
          addingUserId: widget.trainings[index]
              .addingUserId,
          allBodyParts: widget.trainings[index]
              .allBodyParts,
          description: widget.trainings[index]
              .description,
          mainlyUsedBodyPart: widget
              .trainings[index]
              .mainlyUsedBodyPart,
          verified: widget.trainings[index]
              .verified,
        ),
            userID: userID
        ));
  }

  //function to start training
  void startTraining(Return value, user, int index){
    if (value != null) {
      Return updatedValues = value;

      updatedValues.wantToSave ?
      context.read<TrainingPlayBloc>().add(
          UpdateTrainingStatus(training: Training(
              id: widget.trainings[index].id,
              isFinished: updatedValues
                  .isFinished,
              name: widget.trainings[index].name,
              exercises: updatedValues
                  .exercisesNames,
              addingUserId: widget
                  .trainings[index].addingUserId,
              allBodyParts: updatedValues
                  .allBodyParts,
              description: widget.trainings[index]
                  .description,
              mainlyUsedBodyPart: updatedValues
                  .mainlyUsedBodyPart,
              verified: widget.trainings[index]
                  .verified
          ),
              userID: user.id
          ))
          : context.read<TrainingPlayBloc>().add(
          UpdateTrainingStatus(training: Training(
              id: widget.trainings[index].id,
              isFinished: updatedValues.isFinished
                  .sublist(0,
                  widget.trainings[index]
                      .exercises.length),
              name: widget.trainings[index].name,
              exercises: widget.trainings[index]
                  .exercises,
              addingUserId: widget
                  .trainings[index].addingUserId,
              allBodyParts: widget
                  .trainings[index].allBodyParts,
              description: widget.trainings[index]
                  .description,
              mainlyUsedBodyPart: widget
                  .trainings[index]
                  .mainlyUsedBodyPart,
              verified: widget.trainings[index]
                  .verified
          ),
              userID: user.id
          ));

      updatedValues.exercisesSetsCount.every((
          element) => element == 0) ? null :
      context.read<TrainingPlayBloc>().add(
          SaveAsHistoricalTraining(
              history: History(
                id: "",
                name: widget.trainings[index]
                    .name,
                adding_user_id: user.id,
                adding_user_name: user.name ==
                    null ? user.email!
                    .split('@')
                    .first : user.name!,
                exercises_name: updatedValues
                    .exercisesNames.length >
                    widget.trainings[index]
                        .exercises.length
                    ?
                updatedValues.exercisesNames
                    : widget.trainings[index]
                    .exercises,
                exercises_sets_count: updatedValues
                    .exercisesSetsCount,
                exercises_weights: updatedValues
                    .exercisesWeights,
                date: Timestamp.now(),
              ),
              userID: user.id
          ));
      context.read<TrainingPlayBloc>().add(RefreshPlayTrainings(userID: user.id));
    }
    setState(() {
      widget.exercises.clear();
      widget.exercises.addAll(
          widget.originalExercises);
    });
  }

  //function to start training(without internet connection)
  void startTrainingWithoutInternet(Return value, user, int index){
    if (value != null) {
      Return updatedValues = value;

      updatedValues.exercisesSetsCount.every((
          element) => element == 0) ? null :
      context.read<TrainingPlayBloc>().add(
          SaveAsHistoricalTrainingWithoutInternet(
              history: History(
                id: "",
                name: widget.trainings[index]
                    .name,
                adding_user_id: user.id,
                adding_user_name: user.name ==
                    null ? user.email!
                    .split('@')
                    .first : user.name!,
                exercises_name: updatedValues
                    .exercisesNames.length >
                    widget.trainings[index]
                        .exercises.length
                    ?
                updatedValues.exercisesNames
                    : widget.trainings[index]
                    .exercises,
                exercises_sets_count: updatedValues
                    .exercisesSetsCount,
                exercises_weights: updatedValues
                    .exercisesWeights,
                date: Timestamp.now(),
              ),
              userID: user.id
          ));
    }

    setState(() {
      widget.exercises.clear();
      widget.exercises.addAll(
          widget.originalExercises);
    });
  }

  //function that abandons the training and updates it to "to start" mode
  void abandonTraining(int index, String userID){
    context.read<TrainingPlayBloc>().add(
        UpdateTrainingStatus(training: Training(
            id: widget.trainings[index].id,
            isFinished: widget.trainings[index]
                .isFinished.map((e) => e = false)
                .toList(),
            name: widget.trainings[index].name,
            exercises: widget.trainings[index]
                .exercises,
            addingUserId: widget.trainings[index]
                .addingUserId,
            allBodyParts: widget.trainings[index]
                .allBodyParts,
            description: widget.trainings[index]
                .description,
            mainlyUsedBodyPart: widget
                .trainings[index]
                .mainlyUsedBodyPart,
            verified: widget.trainings[index]
                .verified
        ),
            userID: userID
        ));
    }

  //function that skips the training and updates it to "ended" mode
  void skipTraining(int index, String userID){
    context.read<TrainingPlayBloc>().add(
        UpdateTrainingStatus(training: Training(
            id: widget.trainings[index].id,
            isFinished: widget.trainings[index]
                .isFinished.map((e) => e = true)
                .toList(),
            name: widget.trainings[index].name,
            exercises: widget.trainings[index]
                .exercises,
            addingUserId: widget.trainings[index]
                .addingUserId,
            allBodyParts: widget.trainings[index]
                .allBodyParts,
            description: widget.trainings[index]
                .description,
            mainlyUsedBodyPart: widget
                .trainings[index]
                .mainlyUsedBodyPart,
            verified: widget.trainings[index]
                .verified
        ),
            userID: userID
        ));
  }
}

//function that checks the internet connection
Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}

//function that returns a color based on the mode
Color getColor(String mode) {
  switch (mode) {
    case "Progress":
      return const Color.fromARGB(255, 248, 191, 175);
    case "Ended":
      return const Color.fromARGB(255, 197, 255, 188);
    default:
      return Colors.grey;
  }
}


