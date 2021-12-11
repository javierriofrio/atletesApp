import 'dart:html';

import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200.0,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                height: 150,
                width: 150,
                child: FittedBox(
                  fit: BoxFit.contain, // otherwise the logo will be tiny
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/User-Profile.png'),
                  ),
                ),
              )),
          Expanded(
              flex: 6,
              child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Pedro Perez',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('RETOS',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Creados',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                                Text('0',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Completados',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                                Text('10',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ]))),
          Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('1000 pts',
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              )),
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6])),
    );
  }
}
