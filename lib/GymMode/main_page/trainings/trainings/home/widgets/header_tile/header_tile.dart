import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Tooltip(
          message: "Open drawer",
          child: IconButton(
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            icon: Transform.rotate(
              angle: 270 * 3.1416 / 180,
              child: const Icon(Icons.drag_indicator, size: 40),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Center(
            child: Text("Trainings", style: TextStyle(
              color: Color.fromARGB(255, 243, 231, 231),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ), overflow: TextOverflow.ellipsis,),
          )
        ),
      ],
    );
  }
}