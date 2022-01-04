import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/description_event.dart';


import 'event_edit.dart';

class EventList extends StatelessWidget {
  late User user;
  EventList(this.user);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreUtils.firestore.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return ListView.builder(
            shrinkWrap: true,
            itemCount:snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return GestureDetector(
                child: DescriptionEvent(snapshot.data!.docs[index]['name'], snapshot.data!.docs[index]['description'],
                    snapshot.data!.docs[index]['photoURL'].toString()),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEdit(snapshot.data!.docs[index]))),
              );
            },
          );
      });
  }
}
