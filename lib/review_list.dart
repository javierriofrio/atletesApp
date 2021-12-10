import 'package:flutter/material.dart';
import 'package:atletes_sport_app/description_event.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DescriptionEvent("Evento1", "Tiene que tener una de las mejores", "assets/images/welcome_image.png"),
        DescriptionEvent("Evento2", "Tiene que tener una de las mejores", "assets/images/welcome_image.png"),
        DescriptionEvent("Evento3", "Tiene que tener una de las mejores", "assets/images/welcome_image.png")
      ],
    );
  }

}