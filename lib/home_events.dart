import 'package:atletes_sport_app/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_list.dart';
import 'package:atletes_sport_app/header_appbar.dart';

class HomeTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: HeaderAppBar(),
          ),
          Expanded(
              // The ListView
              child: EventList()),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
