import 'package:flutter/material.dart';

/*
* Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */

const size = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.title});
  final String title;
  static const mainColor = Color.fromARGB(255, 79, 171, 151);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: size,),
        SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: Center(
            child: Text(title, style: const TextStyle(
              color: Color.fromARGB(255, 243, 231, 231),
              fontSize: 50,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, 2), blurRadius: 5)],
            ), overflow: TextOverflow.ellipsis,),
          ),
        ),
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.transit_enterexit_rounded, size: size),
          ),
        ),
      ],
    );
  }
}