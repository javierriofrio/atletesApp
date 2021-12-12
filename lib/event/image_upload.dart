import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {

  @override
  _ImageUpload createState() => _ImageUpload();
}

class _ImageUpload extends State<ImageUpload> {
  File? _image;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Center(
              child: _image == null
                  ? Text("No Image is picked")
                  : Image.file(_image!),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () => pickImage(),
          tooltip: "Elegir una imagen",
          child: Icon(Icons.add_a_photo),
        ),
      ],
    );
  }
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this._image = imageTemporary);
  }

}