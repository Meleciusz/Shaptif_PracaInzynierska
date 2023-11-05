import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageProcessor extends StatelessWidget {
  ImageProcessor({super.key, required this.allUsedBodyParts});
  final List<String> allUsedBodyParts;

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
            colorFilter: allUsedBodyParts[0] == bodyPartsList[i] ?
            const ColorFilter.mode(Colors.red, BlendMode.srcATop) :
            allUsedBodyParts.contains(bodyPartsList[i])
                ? const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.srcATop)
                : const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop),
            child: Image.asset(
              "images/BodyParts/" + bodyPartsList[i] + ".png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width,
            ),
          )
      ],
    );
  }
}
