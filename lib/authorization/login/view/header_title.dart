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

    return
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Center(
            child: Text("Login", style: TextStyle(
              color: Color.fromARGB(255, 49, 52, 52),
              fontSize: 47,
              fontWeight: FontWeight.bold,
            ), overflow: TextOverflow.ellipsis,),
        )
    );
  }
}