import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const size = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new, size: size),
            ),
          ]
        ),

        const SizedBox(height: 30.0),
      ],
    );
  }
}