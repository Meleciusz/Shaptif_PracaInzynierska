import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: "Go back",
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Transform.rotate(
              angle: 180 * 3.1416 / 180,
              child: const Icon(Icons.exit_to_app, size: 40),
            ),
          ),
        ),
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
      ],
    );
  }
}