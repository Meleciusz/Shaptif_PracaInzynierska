import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';

/*
 * Main description:
This class is used to display and control color filter of display images
 */
class ImageProcessor extends StatelessWidget {
  ImageProcessor({super.key, required this.allUsedBodyParts, required this.mainlyUsedBodyPart, required this.bodyParts}) :
        bodyPartsNames = bodyParts.map((e) => e.part).toList();

  //list of all used body parts
  final List<String> allUsedBodyParts;

  //mainly used body part
  final String mainlyUsedBodyPart;

  //list of body parts
  final List<BodyParts> bodyParts;

  //list of body parts names
  final List<String> bodyPartsNames;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        for(int i=0; i<bodyPartsNames.length; i++)
          ColorFiltered(
            colorFilter: mainlyUsedBodyPart == bodyPartsNames[i] ?
            const ColorFilter.mode(Colors.red, BlendMode.srcATop) :
            allUsedBodyParts.contains(bodyPartsNames[i])
                ? const ColorFilter.mode(Colors.deepOrangeAccent, BlendMode.srcATop)
                : const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop),
            child: Image.asset(
              "images/BodyParts/${bodyPartsNames[i]}.png",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width,
            ),
          ),
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Color.fromARGB(100, 23, 22, 22), BlendMode.srcATop),
          child: Image.asset(
            "images/BodyParts/Rest.png",
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width,
          ),
        )
      ],
    );
  }
}
