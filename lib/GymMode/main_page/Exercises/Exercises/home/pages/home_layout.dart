import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_page.dart';
import 'package:container_body/container_body.dart';
import '../widgets/exercises_by_category/exercises_by_category.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);
    final ExercisesByCategoryBloc exercisesByCategoryBloc = BlocProvider.of<ExercisesByCategoryBloc>(context);
    const mainColor = Color.fromARGB(255, 196, 115, 115);

    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(
              switchCallback: (){
                context.read<MainPageBloc>().add(ChangeCategory());
              },
            ),
            const SizedBox(height: 20),
            const ContainerBody(
              children: [
                //ExerciseOrTrainingsStateWidget(),
                CategoriesWidget(),
                SizedBox(height: 20),
                ExercisesByCategory(),
                SizedBox(height: 20),
                AllExercisesWidget(title: 'All exercises'),
              ],
            ),
          ],
        ),
      ),
    floatingActionButton: FabCircularMenu(
        fabOpenColor: mainColor,
        fabColor: mainColor,
        ringColor: mainColor,
        children: <Widget>[
        FutureBuilder<bool>(
          future: _checkInternetConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return Tooltip(
                  message: "Refresh exercises",
                  child: IconButton(
                    onPressed: (){
                      allExercisesBloc.add(RefreshExercises());
                      exercisesByCategoryBloc.add(RefreshExercisesByCategory());
                    },
                    icon:  const Icon(Icons.refresh),
                  ),
                );
              }
              return const Tooltip(
                  message: 'Refresh',
                  child: Icon(Icons.refresh, color: Colors.grey,));
            }else {
              return const CircularProgressIndicator();
            }
          }
        ),
          FutureBuilder<bool>(
              future: _checkInternetConnection(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    return Tooltip(
                      message: 'Add new exercise',
                      child:    IconButton(
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => NewExercise(allExercisesBloc: allExercisesBloc, exercisesByCategoryBloc: exercisesByCategoryBloc)
                              )
                          ).whenComplete((){
                            allExercisesBloc.add(RefreshExercises());
                            exercisesByCategoryBloc.add(RefreshExercisesByCategory());
                          });
                        },
                        icon:  const Icon(Icons.add),
                      ),
                    );
                  }
                  return const Tooltip(
                      message: 'Add new exercise',
                      child: Icon(Icons.add, color: Colors.grey,));
                }else {
                  return const CircularProgressIndicator();
                }
              }
          ),
          Tooltip(
            message: 'QA',
            child: IconButton(onPressed: (){}, icon: const Icon(Icons.question_mark)),
          )
        ]
      ),
      drawer: Drawer(
        child: ListView(

        )
      )
    );

  }
}

Future<bool> _checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  }else {
    return false;
  }
}