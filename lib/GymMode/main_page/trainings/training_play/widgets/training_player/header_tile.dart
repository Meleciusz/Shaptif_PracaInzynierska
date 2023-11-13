import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: "Go back",
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, size: 40,)
          ),
        ),
        Tooltip(
          message: "Abandon training",
          child: IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.not_interested_rounded, color: Color.fromARGB(
                  255, 204, 42, 42), size: 40,)
          ),
        ),
        Tooltip(
          message: "Refresh training",
          child: IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.refresh, color: Color.fromARGB(
                  255, 204, 42, 42), size: 40,)
          ),
        ),
      ],
    );
  }
}