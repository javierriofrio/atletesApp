import 'package:flutter/material.dart';

class DescriptionNotification extends StatelessWidget {
  final String nameEvent;
  final String dateLimit;

  DescriptionNotification(this.nameEvent, this.dateLimit);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final event = Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(nameEvent),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      dateLimit,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));

    return  Container(
      child: event,
    );
  }
}
