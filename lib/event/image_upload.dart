import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    backgroundColor: Colors.white,
    return Scaffold(
    appBar: AppBar(
    title: Text('Upload Image', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.white,
    ),
    body: Container()
    );
  }
}