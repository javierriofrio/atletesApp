import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:atletes_sport_app/event/image_upload.dart';

class EventForm extends StatelessWidget {
  File? image;
  late String imageUrl = 'https://i.imgur.com/sUFH1Aq.png';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      child: new SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20.20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.event),
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.event_note),
                labelText: 'Descripcion',
              ),
            ),
            BasicDateField(),
            ImageUpload(),
          ],
        ),
      )),
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.calendar_today),
          labelText: 'Fecha Limite',
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
