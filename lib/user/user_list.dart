import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/description_event.dart';

class UserList extends StatelessWidget {
  late User user;
  UserList(this.user);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreUtils.firestore.collection('users').snapshots(),
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
                child: DescriptionEvent(snapshot.data!.docs[index]['firstName'], snapshot.data!.docs[index]['lastName'],
                    snapshot.data!.docs[index]['photoURL'].toString()),
                /*onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEdit(this.user, snapshot.data!.docs[index].id))),*/
              );
            },
          );
      });/*,
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Card(
                child: DescriptionEvent(snapshot.data.name, snapshot[index].description,
                    snapshot[index].photoURL.toString());
              );
            }).toList(),
          );
      },
    );*/
  }

    /*StreamBuilder(
      stream: FireStoreUtils.firestore.collection('EVENTS').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          child: DescriptionEvent(snapshot.data.name, snapshot.data.description,
              snapshot.data.photoURL.toString());
        };
      }
    ),*/
    /*ListView(

      children: FireStoreUtils.firestore.collection('EVENTS').snapshots().map((event) => {
          return DescriptionEvent(snapshot.data.name, snapshot.data.description,
          snapshot.data.photoURL.toString());
      }),
    )*/

    /*);*//*ListView.builder(
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) {
        DocumentSnapshot user = snapshot.data.documents[index];

        return DescriptionEvent(snapshot[index].name, snapshot[index].description,
            snapshot[index].photoURL.toString());
      },
    );*/
  /*}*/

/*  Widget _itemBuilder (BuildContext context, int index){
    return DescriptionEvent(listEvents[index].name, listEvents[index].description,
        listEvents[index].photoURL.toString());
  }*/
}
