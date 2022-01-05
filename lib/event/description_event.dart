import 'package:flutter/material.dart';

class DescriptionEvent extends StatelessWidget {
  final String nameEvent;
  final String descriptionEvent;
  final String imagenURL;

  DescriptionEvent(this.nameEvent, this.descriptionEvent, this.imagenURL);

  ///Método build para construir el widget para descripcion de eventos
  @override
  Widget build(BuildContext context) {

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
                      descriptionEvent,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Image.network(imagenURL)),
          ],
        ));

    return  Container(
      child: event,
    );
  }
}
