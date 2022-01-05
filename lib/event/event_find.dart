import 'package:flutter/material.dart';
import 'package:atletes_sport_app/header_appbar.dart';
import 'package:atletes_sport_app/event/event_list.dart';
import 'package:atletes_sport_app/user/model/user.dart';

class EventHome extends StatelessWidget {
  late User user;
  EventHome(this.user);

  @override
  Widget build(BuildContext context) {

    final event = Column(
      children: [
        Container(
          child: HeaderAppBar(this.user),
        ),
        Expanded(
          // The ListView
            child: EventList(this.user)),
      ],
    );

    return Container(
      child: event,
    );
  }
}
