import 'package:atletes_sport_app/user/user_list.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/header_appbar.dart';
import 'package:atletes_sport_app/user/model/user.dart';

class UserFind extends StatelessWidget {
  late User user;
  UserFind(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final event = Column(
      children: [
        Container(
          child: HeaderAppBar(this.user),
        ),
        Expanded(
          // The ListView
            child: UserList(this.user)),
      ],
    );

    return Container(
      child: event,
    );
  }
}
