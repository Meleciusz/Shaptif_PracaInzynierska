import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../authorization/app/bloc/app_bloc.dart';

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
              icon: const Icon(Icons.drag_indicator)
          ),
        ),
        const Text("Exercises", style: TextStyle(
          color: Color.fromARGB(255, 243, 231, 231),
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ), overflow: TextOverflow.ellipsis,),
        Tooltip(
          message: "Log out",
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.exit_to_app)
          ),
        ),
      ],
    );
  }
}