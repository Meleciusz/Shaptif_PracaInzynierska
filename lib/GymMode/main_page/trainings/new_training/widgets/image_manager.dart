import 'package:flutter/material.dart';

/*
 * Main description:
This class is used to display and control color filter of display images
 */
class ImageProcessor extends StatelessWidget {
  ImageProcessor({super.key, required this.allUsedBodyParts, required this.mainlyUsedBodyPart});

  //list of all used body parts
  final List<String> allUsedBodyParts;

  //mainly used body part
  final String mainlyUsedBodyPart;

  //list of body parts
  final List<String> bodyPartsList = List.of(
      [
        "Adductor", "Biceps", "Butt", "Calf", "Chest", "CoreAbs", "Deltoid", "Dorsi", "DownAbs", "Femoris",
        "Forearm", "Quadriceps", "Rest", "Shoulders", "SideAbs", "Trapezius", "Triceps", "UpAbs"
      ]
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        for(int i=0; i<bodyPartsList.length; i++)
          ColorFiltered(
            colorFilter: mainlyUsedBodyPart == bodyPartsList[i] ?
            const ColorFilter.mode(Colors.red, BlendMode.srcATop) :
            allUsedBodyParts.contains(bodyPartsList[i])
                ? const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.srcATop)
                : const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop),
            child: Image.asset(
              "images/BodyParts/${bodyPartsList[i]}.png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width,
            ),
          )
      ],
    );
  }
}
