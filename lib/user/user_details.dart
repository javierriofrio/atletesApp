import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Expanded(
        child: new Padding(
          padding: const EdgeInsets.all(20.20),
          child: Text('Nombre'),
        ),
      ),
      Expanded(
        child: new Padding(
          padding: const EdgeInsets.all(20.20),
          child: TextField (
            decoration: InputDecoration(
                hintText: 'Ingrese el nombre'
            ),
          )
        ),
      )
    ]);
  }
}
