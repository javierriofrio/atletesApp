import 'dart:async';

import 'package:atletes_sport_app/event/model/event.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'description_event.dart';

class EventFind extends StatefulWidget {
  @override
  _EventFind createState() => new _EventFind();
}

class _EventFind extends State<EventFind> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getEventDetails() async {
    setState(() {
      // Get json result and convert it to model. Then add
    });
  }

  @override
  void initState() {
    super.initState();
    getEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Buscar Evento'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Buscar', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
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
                      FireStoreUtils.firestore.collection('events').snapshots(),
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
                            child: DescriptionEvent(
                                snapshot.data!.docs[index]['name'],
                                snapshot.data!.docs[index]['description'],
                                snapshot.data!.docs[index]['photoURL']
                                    .toString()),
                            /*onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEdit(this.user, snapshot.data!.docs[index].id))),*/
                          );
                        },
                      );
                  }))
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _eventDetails.forEach((eventDetails) {
      if (eventDetails.name.contains(text)) _searchResult.add(eventDetails);
    });

    setState(() {});
  }
}

List _searchResult = [];

List _eventDetails = [];

/*
import 'dart:async';

import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/header_appbar.dart';
import 'package:atletes_sport_app/event/event_list.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/event/model/event.dart';

import 'description_event.dart';

class EventFind extends StatefulWidget {
  final User user;

  const EventFind({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _EventState();
}

class _EventState extends State<EventFind> {
  late User user;

  Stream<QuerySnapshot<Map<String, dynamic>>> _dataFromQuerySnapShot = FireStoreUtils.firestore.collection('events').snapshots();
  @override
  Widget build(BuildContext context) {
    final event = Column(
      children: [
        TextField(onChanged: _filter),
        StreamBuilder<QuerySnapshot>(

    stream: (searchKey != null || searchKey != "")
    ? searchData(searchKey)
        : stream(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
    child: CircularProgressIndicator(),
    );
    }
    if (!snapshot.hasData) {
    return Center(
    child: Text("Error"),
    );
    }
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: DescriptionEvent(
                            snapshot.data!.docs[index]['name'],
                            snapshot.data!.docs[index]['description'],
                            snapshot.data!.docs[index]['photoURL'].toString()),
                      );
                    },
                  );
              }),
        ),
      ],
    );

  }
  StreamController<List<Event>> _streamController = StreamController<List<Event>>();
  Stream<List<Event>> get _stream => _streamController.stream;
  _filter(String searchQuery) {
    List _filteredList = FireStoreUtils.firestore.collection('events').snapshots().
        where((Event event) => event.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList() as List;
    _streamController.sink.add(_filteredList);
  }
}
*/
