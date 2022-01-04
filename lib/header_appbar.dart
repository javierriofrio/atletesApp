import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/model/user.dart';

class HeaderAppBar extends StatelessWidget {
  late User user;
  HeaderAppBar(this.user);

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
                    child: Image.network(user.profilePictureURL),
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
                                Text(user.firstName + user.lastName,
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
                                Text('RETOS',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white))
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
                                        fontSize: 15, color: Colors.white)),
                                Text(user.created.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Completados',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                Text(user.completed.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white))
                              ],
                            ),
                          ],
                        ),
                      ]))),
          Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(20.20),
                child: Column(
                  children: [
                    Text(user.points + ' pts',
                        style: TextStyle(fontSize: 10, color: Colors.white))
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
