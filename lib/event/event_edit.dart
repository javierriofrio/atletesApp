import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/event/model/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'event_edit_form.dart';

class EventEdit extends StatelessWidget {

  final DocumentSnapshot event;

  EventEdit(this.event);

  static getEvent(String eventId) async {
    print(eventId);
    Event? event = await FireStoreUtils.getCurrentEvent(eventId);
    return event;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Competir Eventos'),
        centerTitle: true,
      ),
      body: EventEditForm(this.event),
    );
  }
}
