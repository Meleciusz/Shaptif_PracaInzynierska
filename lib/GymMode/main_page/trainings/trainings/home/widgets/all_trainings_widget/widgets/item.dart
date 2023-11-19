import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../../../trainings_description/trainings_description.dart';

class AllTrainingsItem extends StatelessWidget {
  const AllTrainingsItem({super.key, required this.training});
  final Training training;

  @override
  Widget build(BuildContext context) {
    final AllTrainingsBloc allTrainingsBloc = BlocProvider.of<AllTrainingsBloc>(context);
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocBuilder<AllTrainingsBloc, AllTrainingsState>(
        builder: (context, state){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TrainingsDescription(training: training)
                  )
              );
            },
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.withOpacity(.1),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 25.0,
                    left: 20.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: Text(
                        training.name ?? "",
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 65.0,
                      left: 100.0,
                      child: AllTrainingsIcon(
                        veryfied: training.verified,
                        addingUserName: training.addingUserName,
                      )
                  ),
                  Positioned(
                      top: 65.0,
                      left: 20.0,
                      child: IconButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: const Text("Are you sure?"),
                                content: const Text("This training will be deleted forever!."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      training.verified ? null :
                                        training.addingUserId == user.id ?
                                        allTrainingsBloc.add(DeleteTraining(trainingID: training.id)) : null;

                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        backgroundColor: Colors.red
                                    ),
                                    child: const Text("Delete"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        backgroundColor: Colors.green
                                    ),
                                    child: const Text("Go back"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.remove, color: Colors.redAccent, size: 30,),
                      )
                  ),
                ]
              ),
            ),
          );
        }
    );
  }
}