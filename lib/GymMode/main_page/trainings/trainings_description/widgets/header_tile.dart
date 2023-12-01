import 'package:flutter/material.dart';


/*
 * Main description:
This is HeaderTitle widget
HeaderTitle - Upper part of the screen where title and IconButtons are displayed
 */
class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.add), color: const Color.fromARGB(0, 0, 0, 0),),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Description", style: TextStyle(
                color: Color.fromARGB(255, 243, 231, 231),
                fontSize: 40,
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