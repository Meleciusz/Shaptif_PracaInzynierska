import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


/*
 * Main description:
 This is Image Adder
 This class allow user to add image to exercise
 */
class ImageAdder extends StatefulWidget {
  const ImageAdder({super.key, required this.onUrlChanged});

  // return photo url
  final void Function(String) onUrlChanged;

  @override
  State<ImageAdder> createState() => _ImageAdderState();
}

class _ImageAdderState extends State<ImageAdder> {
  //photo url
  String url = "";

  //set photo url
  setUrl (String url) {
    setState(() {
      this.url = url;
      widget.onUrlChanged(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        ImagePicker imagePicker = ImagePicker();
        XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

        if (file == null) {
          return;
        }
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference referenceDirImages = referenceRoot.child("ExercisesImages");

          String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
          Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

          try{
            await referenceImageToUpload.putFile(File(file!.path));
            url = await referenceImageToUpload.getDownloadURL();
            await setUrl(url);

          }catch(e){
            log("Failed to upload image");
          }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: url.isNotEmpty
          ? Image.network(url)
            : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.camera_enhance_rounded, size: 100.0),
              Text("Add image", style : Theme.of(context).textTheme.headlineSmall),
            ]
        ),
      ),
    );
  }
}