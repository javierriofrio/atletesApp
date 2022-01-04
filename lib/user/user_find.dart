import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/model/user.dart';

class UserFind extends StatelessWidget {
  late User user;

  UserFind(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Usuarios'),
          centerTitle: true,
        ),
        body: new Column(children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    decoration: new InputDecoration(
                        hintText: 'Buscar', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                  FireStoreUtils.firestore.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child:
                              ListTile(
                                leading: Icon(Icons.star ),
                                title: Text(snapshot.data!.docs[index]['firstName'] + " " + snapshot.data!.docs[index]['lastName']),
                          )
                            /*onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEdit(this.user, snapshot.data!.docs[index].id))),*/
                          );
                        },
                      );
                  }))

        ]));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
  }

  List _searchResult = [];

  List _eventDetails = [];
}
