import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import 'package:training_repository/training_repository.dart';
import '../../../../../trainings_description/trainings_description.dart';
import '../../category_widget/bloc/category_widget_bloc.dart';

/*
 * Main description:
This file describes item of all trainings widget

 */
class AllTrainingsItem extends StatelessWidget {
  const AllTrainingsItem({super.key, required this.training});

  // displayed training
  final Training training;

  @override
  Widget build(BuildContext context) {

    // allTrainingsBloc from context
    final AllTrainingsBloc allTrainingsBloc = BlocProvider.of<AllTrainingsBloc>(context);

    // user from context
    final user = context.select((AppBloc bloc) => bloc.state.user);

    // categoryBloc from context
    final CategoryBloc categoryBloc = BlocProvider.of<CategoryBloc>(context);


    return BlocBuilder<AllTrainingsBloc, AllTrainingsState>(
        builder: (context, state){
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TrainingsDescription(training: training, bodyParts: categoryBloc.state.categories,)
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
                        verified: training.verified,
                        addingUserId: training.addingUserId,
                      )
                  ),

                  // If training is not verified, user who want to delete it is the same user who created it and user have access to Internet connection
                  training.verified == false ?
                  training.addingUserId == user.id ?
                  FutureBuilder(
                      future: _checkInternetConnection(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == true) {

                            //If user have access to Internet connection show delete button
                            return Positioned(
                                top: 50.0,
                                left: 20.0,
                                child: IconButton(
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {

                                        //Show Alert Dialog, whenever user clicks on delete button
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0),
                                          ),
                                          title: const Text("Are you sure?"),
                                          content: const Text("This training will be deleted forever!."),
                                          actions: [
                                            ElevatedButton(
                                              key: const Key('delete'),
                                              onPressed: () {
                                                allTrainingsBloc.add(DeleteTraining(
                                                    trainingID: training.id,
                                                    userID: user.id
                                                ));

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
                                  icon: const Icon(Icons.remove, color: Colors.redAccent, size: 40,),
                                )
                            );
                          }
                          else {
                            return const SizedBox(height: 0);
                          }
                        }else {
                          return const CircularProgressIndicator();
                        }
                      }
                  ) : Container() : Container(),
                ]
              ),
            ),
          );
        }
    );
  }
}


//This function is responsible for checking the internet connection.
Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}