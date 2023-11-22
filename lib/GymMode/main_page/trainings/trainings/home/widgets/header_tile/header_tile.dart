import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.switchCallback});
  final VoidCallback switchCallback;

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Tooltip(
          message: "Open drawer",
          child: IconButton(
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.drag_indicator_outlined, size: 40),
            ),
          ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const Center(
            child: Text("Trainings", style: TextStyle(
              color: Color.fromARGB(255, 243, 231, 231),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ), overflow: TextOverflow.ellipsis,),
          )
        ),
        Tooltip(
          message: "Switch to exercises",
          child: IconButton(
            onPressed: (){
              switchCallback();
            },
            icon: const Icon(Icons.switch_left_rounded, size: 40),
          ),
        ),
      ],
    );
  }
}