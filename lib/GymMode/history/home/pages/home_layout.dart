import 'package:flutter/material.dart';
import 'package:container_body/container_body.dart';
import '../../widgets/header_title.dart';
import '../home.dart';

/*
 * Main description:
This is history layout
This class define what is displayed on history screen

 * Elements:
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
ContainerBody - Custom container to display Widgets
ShowHistoryWidget - Widget to display
 */

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});
  static const mainColor = Color.fromARGB(255, 79, 171, 151);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mainColor,
      body: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTitle(),
              SizedBox(height: 20),
              ContainerBody(
                  children: [
                    ShowHistoryWidget(),
                  ]
              ),
            ],
          )
      ),
      //drawer: Drawer(),
    );
  }
}