import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key, required this.onRefreshTap});
  final VoidCallback onRefreshTap;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Tooltip(
            message: "Refresh",
            child: IconButton(
              onPressed: (){
                onRefreshTap();
              },
              icon:  const Icon(Icons.refresh, size: 40,),
            )
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Center(
              child: Text("New Exercise", style: TextStyle(
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
            icon: const Icon(Icons.transit_enterexit_rounded, size: 40),
          ),
        ),
      ],
    );
  }
}