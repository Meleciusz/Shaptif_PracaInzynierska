import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onQuickStartTap});

  final VoidCallback onQuickStartTap;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Tooltip(
          message: "Start quick training",
          child: IconButton(
              onPressed: (){
                onQuickStartTap();
              },
            icon:  const Icon(Icons.local_fire_department_outlined, size: 60, color: Color.fromARGB(
                  255, 224, 94, 124), shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-2, -2), blurRadius: 2)],
            ),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Center(
              child: Text("Play", style: TextStyle(
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