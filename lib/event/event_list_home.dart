import 'package:flutter/material.dart';
import 'package:atletes_sport_app/header_appbar.dart';
import 'package:atletes_sport_app/event/event_list.dart';

class EventHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final event = Column(
      children: [
        Container(
          child: HeaderAppBar(),
        ),
        Expanded(
          // The ListView
            child: EventList()),
      ],
    );

    return  Container(
      child: event,
    );
  }
}
