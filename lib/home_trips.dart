import 'package:flutter/material.dart';
import 'package:atletes_sport_app/description_event.dart';
import 'package:atletes_sport_app/header_appbar.dart';
import 'package:atletes_sport_app/review_list.dart';

class HomeTrips extends StatelessWidget {
  final String descriptionDummy = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            ReviewList()

          ],
        ),
      ],
    );
  }

}