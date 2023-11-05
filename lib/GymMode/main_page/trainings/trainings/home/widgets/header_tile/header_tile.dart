import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Training screen",
          style: textTheme.headlineSmall,),
        ],
    );
  }
}