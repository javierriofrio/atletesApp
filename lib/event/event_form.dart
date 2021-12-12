import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
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
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_today),
                labelText: 'Fecha Limite',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.add_a_photo),
                labelText: 'Agregar Foto',
              ),
            ),
            new Container(
              width: 150,
              child: new ElevatedButton(
                child: new Text(
                  'Login',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: () => {},
              ),
              margin: new EdgeInsets.only(top: 20.0),
            )
          ],
        ),
      ),
    );
  }
 }
