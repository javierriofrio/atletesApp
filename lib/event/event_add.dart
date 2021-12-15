import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_form.dart';

class EventAdd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Crear Eventos'),
        centerTitle: true,
      ),
      body: EventForm(),
    );
  }
}
