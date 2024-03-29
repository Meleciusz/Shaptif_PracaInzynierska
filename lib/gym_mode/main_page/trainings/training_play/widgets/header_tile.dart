import 'package:flutter/material.dart';

/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onQuickStartTap});

  //This function is called when quick start button is pressed
  final VoidCallback onQuickStartTap;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: "Start quick training",
          child: IconButton(
              onPressed: (){
                onQuickStartTap();
              },
            icon:  const Icon(Icons.local_fire_department_outlined, size: 50, color: Color.fromARGB(
                  255, 224, 94, 124), shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
            ),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Play", style: TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ), overflow: TextOverflow.ellipsis,),
            )
        ),
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.transit_enterexit_rounded, size: 40),
            ),
          ),
      ],
    );
  }
}