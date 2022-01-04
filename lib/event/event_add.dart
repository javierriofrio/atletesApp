import 'package:atletes_sport_app/user/model/user.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_form.dart';

class EventAdd extends StatelessWidget {

  late User user;
  EventAdd(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Crear Eventos'),
        centerTitle: true,
      ),
      body: EventForm(this.user),
    );
  }
}
