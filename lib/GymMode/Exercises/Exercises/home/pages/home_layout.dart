import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/header_title/header_title.dart';
import '../../../../history/history.dart';
import '../../../NewExercise/home/home.dart';
import '../../widgets/container_body.dart';
import '../widgets/all_exercises_widget/all_exercises.dart';
import '../widgets/category_widget/category_widget_manager.dart';
import 'package:fab_circural_menu/src/fab_circural_menu.dart';

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

    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(),
            SizedBox(height: 20),
            ContainerBody(
              children: [
                CategoriesWidget(),
                ExercisesByCategory(),
                AllExercisesWidget(title: 'All exercises'),
              ],
            ),
          ],
        ),
      ),
    floatingActionButton: FabCircularMenu(
        children: <Widget>[
        FutureBuilder<bool>(
          future: _checkInternetConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return IconButton(
                  onPressed: (){
                    allExercisesBloc.add(RefreshExercises());
                    //exercisesByCategoryBloc.add(RefreshExercisesByCategory());
                  },
                  icon:  const Icon(Icons.refresh),
                );
              }
              return const SizedBox(height: 0.0, width: 0.0);
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
                    return IconButton(
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => NewExercise(allExercisesBloc: allExercisesBloc)
                            )
                        );
                      },
                      icon:  const Icon(Icons.add),
                    );
                  }
                  return const SizedBox(height: 0.0, width: 0.0);
                }else {
                  return const CircularProgressIndicator();
                }
              }
          ),
          IconButton(icon: const Icon(Icons.play_arrow_outlined),
          onPressed: (){}
            ,),
          IconButton(icon: const Icon(Icons.auto_stories),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const HomePageHistory())
              );
            }
            ,),
          IconButton(onPressed: (){}, icon: const Icon(Icons.question_mark))
        ]
      ),
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