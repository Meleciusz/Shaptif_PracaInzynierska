import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:container_body/container_body.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../history/history.dart';
import '../../../../bloc/main_page_bloc.dart';
import '../widgets/category_widget/category_widget_manager.dart';
import '../widgets/header_tile/header_tile.dart';
import '../widgets/trainings_by_category/trainings_by_category_manager.dart';
import '../widgets/widgets.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 188, 218, 124);

    return Scaffold(
      backgroundColor: mainColor,
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
                  SizedBox(height: 20),
                  TrainingsByCategory(),
                  SizedBox(height: 20),
                  AllTrainingsWidget(),
                ]
            )
          ]
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
                      return IconButton(
                        onPressed: (){
                          //allExercisesBloc.add(RefreshExercises());
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
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => NewExercise(allExercisesBloc: allExercisesBloc, exercisesByCategoryBloc: exercisesByCategoryBloc)
                          //     )
                          // );
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
            Tooltip(
              message: "Switch to trainings",
              child: IconButton(icon: const Icon(Icons.switch_access_shortcut_add_rounded),
                onPressed: (){
                  context.read<MainPageBloc>().add(ChangeCategory());
                }
                ,),
            ),
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