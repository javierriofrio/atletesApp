import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'description_notification.dart';

class NotificationUI extends StatelessWidget {
  late User user;

  NotificationUI(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Crear Eventos'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FireStoreUtils.firestore.collection('notification').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: const ListTile(
                        leading: Icon(Icons.album),
                        title: Text('La vuelta a la carolina'),
                        subtitle: Text('Este evento mas importante del pais'),
                      ),
                    );
                  },
                );
            }));
  }
}
