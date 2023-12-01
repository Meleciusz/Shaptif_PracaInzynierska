import 'package:flutter/material.dart';

/*
 * Main description:
This class is used to display and control color filter of display images
 */

class ImageProcessor extends StatefulWidget {
  const ImageProcessor({Key? key, required this.selectedBodyParts}) : super(key: key);

  final Set<String> selectedBodyParts;

  @override
  _ImageProcessorState createState() => _ImageProcessorState();
}

class _ImageProcessorState extends State<ImageProcessor> {

  // List of body parts
  final List<String> bodyPartsList = [
    "Adductor", "Biceps", "Butt", "Calf", "Chest", "CoreAbs", "Deltoid", "Dorsi",
    "DownAbs", "Femoris", "Forearm", "Quadriceps", "Rest", "Shoulders",
    "SideAbs", "Trapezius", "Triceps", "UpAbs"
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        for(int i=0; i<bodyPartsList.length; i++)
          ColorFiltered(
            colorFilter: widget.selectedBodyParts.isNotEmpty ? widget.selectedBodyParts.first == bodyPartsList[i] ?
            const ColorFilter.mode(Colors.red, BlendMode.srcATop) :
            widget.selectedBodyParts.contains(bodyPartsList[i])
                ? const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.srcATop)
                : const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop) :
            const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop),
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
