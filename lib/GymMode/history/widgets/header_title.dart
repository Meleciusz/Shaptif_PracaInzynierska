import 'package:flutter/material.dart';

const size = 40.0;

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({super.key});

  final String title = "History";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: size),
        ),
        const SizedBox(width: 30.0),
        Padding(
            padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}