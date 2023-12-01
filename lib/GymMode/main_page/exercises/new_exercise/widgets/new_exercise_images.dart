import 'package:flutter/material.dart';
import 'image_adder.dart';
import 'image_manager.dart';

/*
*Main description:
This class is used to display images
 */
class NewExerciseImages extends StatelessWidget {
  const NewExerciseImages({super.key, required this.selectedBodyParts, required this.handleUrlChanged, required this.iconController});

  //set of selected body parts
  final Set<String> selectedBodyParts;

  //return photo url
  final void Function(String) handleUrlChanged;

  //iconController is used for image animation change
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: ImageProcessor(selectedBodyParts: selectedBodyParts),
                )
            ),
            Opacity(
                opacity: iconController ? 1.0 : 0.0,
                child: SizedBox(
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