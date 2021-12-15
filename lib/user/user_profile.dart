import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/user_details.dart';
import 'package:atletes_sport_app/bottom_bar.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Usuario'),
          centerTitle: true,
        ),
        body: UserDetails(),
      bottomNavigationBar: BottomBar(),
    );
  }

}