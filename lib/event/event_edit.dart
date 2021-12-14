import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:flutter/material.dart';


import 'event_edit_form.dart';

class EventEdit extends StatelessWidget {

  late User user;
  late String eventId;
  EventEdit(this.user, String eventId);

  static getEvent(String eventId) async {
    return await FireStoreUtils.getCurrentEvent(eventId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Crear Eventos'),
        centerTitle: true,
      ),
      body: EventEditForm(this.user, eventId),
    );
  }
}
