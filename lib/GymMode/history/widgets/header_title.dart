import 'package:flutter/material.dart';

const size = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  final String title = "History";

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
                child: const Icon(Icons.drag_indicator, size: size),
              ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: const Center(
            child: Text("History", style: TextStyle(
            color: Color.fromARGB(255, 243, 231, 231),
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ), overflow: TextOverflow.ellipsis,),)
        ),
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle: 180 * 3.1416 / 180,
              child: const Icon(Icons.exit_to_app, size: size),
            ),
          ),
        ),
      ],
    );
  }
}