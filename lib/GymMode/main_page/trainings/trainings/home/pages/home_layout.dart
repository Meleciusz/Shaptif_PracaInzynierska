import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:container_body/container_body.dart';
import 'package:fab_circural_menu/fab_circural_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/category_widget/bloc/category_widget_bloc.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import '../../../../../history/history.dart';
import '../../../../bloc/main_page_bloc.dart';
import '../../../new_training/new_training.dart';
import '../../../training_play/home/home.dart';
import '../widgets/category_widget/category_widget_manager.dart';
import '../widgets/header_tile/header_tile.dart';
import '../widgets/widgets.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 130, 189, 149);
    final user = context.select((AppBloc bloc) => bloc.state.user);

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
                  CategoriesWidget(),
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
                      return Tooltip(
                        message: 'Refresh',
                        child: IconButton(
                          onPressed: (){
                            context.read<AllTrainingsBloc>().add(RefreshAllTrainings(userID: user.id));
                            context.read<CategoryBloc>().add(SelectCategory(idSelected: 0));
                          },
                          icon:  const Icon(Icons.refresh),
                        ),
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
                      return Tooltip(
                        message: 'New training',
                        child: IconButton(
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const NewTrainingPage()
                                )
                            ).whenComplete(() {
                              context.read<AllTrainingsBloc>().add(RefreshAllTrainings(userID: user.id));
                            });
                          },
                          icon:  const Icon(Icons.add),
                        ),
                      );
                    }
                    return const SizedBox(height: 0.0, width: 0.0);
                  }else {
                    return const CircularProgressIndicator();
                  }
                }
            ),
            Tooltip(
              message: 'History',
              child: IconButton(icon: const Icon(Icons.auto_stories),
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const HomePageHistory())
                  );
                }
                ,)
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.question_mark)),
            Tooltip(
              message: 'Trainings play',
              child: IconButton(onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const TrainingPlay()
                    )
                ).whenComplete((){
                  context.read<AllTrainingsBloc>().add(RefreshAllTrainings(userID: user.id));
                });
              },
                  icon: const Icon(Icons.play_arrow_outlined)),
            )
          ]
      ),
      drawer: Drawer(
        child: Container(
        )
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