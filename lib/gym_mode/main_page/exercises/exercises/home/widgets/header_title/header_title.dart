import 'package:flutter/material.dart';

/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.switchCallback});

  //function to switch to trainings
  final void Function() switchCallback;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 40,),
        // Tooltip(
        //   message: "Open drawer",
        //   child: IconButton(
        //       onPressed: (){
        //         Scaffold.of(context).openDrawer();
        //       },
        //       icon: const Icon(Icons.drag_indicator, size: 40),
        //     ),
        //   ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Exercises", style: TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ), overflow: TextOverflow.ellipsis,),
            )
        ),
        Tooltip(
          message: "Switch to trainings",
          child: IconButton(
            onPressed: (){
              switchCallback();
            },
            icon: const Icon(Icons.switch_right_rounded, size: 40),
          ),
        ),
      ],
    );
  }
}