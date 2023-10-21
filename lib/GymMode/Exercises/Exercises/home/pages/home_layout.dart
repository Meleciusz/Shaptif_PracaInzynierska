import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/exercises_by_category.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/header_title/header_title.dart';
import '../../widgets/container_body.dart';
import '../widgets/all_exercises_widget/all_exercises.dart';
import '../widgets/category_widget/category_widget_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);

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
      floatingActionButton: FutureBuilder<bool>(
        future: _checkInternetConnection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                onPressed: (){
                  allExercisesBloc.add(RefreshExercises());
                },
                child:  const Icon(Icons.refresh),
              );
            }
            return const SizedBox(height: 0.0, width: 0.0);
          }else {
            return const CircularProgressIndicator();
          }
        }
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
