import 'package:flutter/material.dart';

class ImageAdder extends StatelessWidget {
  const ImageAdder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.camera_enhance_rounded, size: 100.0),
          Text("Dodaj zdjęcie", style : Theme.of(context).textTheme.headlineSmall),
        ]
      ),
    );
  }
}