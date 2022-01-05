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
                    snapshot.data!.docs[index]['profilePictureURL']),
               /* onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEdit(this.user, snapshot.data!.docs[index].id))),*/
              );
            },
          );
      });
  }

}
