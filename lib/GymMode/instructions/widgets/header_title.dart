import 'package:flutter/material.dart';

/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */

double size = 40;
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: size,),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Center(
              child: Text(title, style: const TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 47,
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
            icon: Icon(Icons.transit_enterexit_rounded, size: size),
          ),
        ),
      ],
    );
  }
}