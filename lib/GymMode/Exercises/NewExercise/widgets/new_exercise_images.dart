import 'package:flutter/material.dart';
import 'image_adder.dart';
import 'image_manager.dart';

class NewExerciseImages extends StatelessWidget {
  const NewExerciseImages({super.key, required this.selectedBodyParts, required this.handleUrlChanged, required this.iconController});
  final Set<String> selectedBodyParts;
  final void Function(String) handleUrlChanged;
  final bool iconController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
                opacity: iconController ? 0.0 : 1.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: ImageProcessor(selectedBodyParts: selectedBodyParts),
                )
            ),
            Opacity(
                opacity: iconController ? 1.0 : 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: ImageAdder(onUrlChanged: handleUrlChanged),
                )
            ),
          ],
        ),
      ]
    );

  }
}