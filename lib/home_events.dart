import 'package:atletes_sport_app/user/user_details.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/event/event_list_home.dart';

class HomeEvents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeEvents();
  }

}

class _HomeEvents extends State<HomeEvents> {
  int indexTap = 0;
  final List<Widget> widgetsChildren = [
    EventAdd(),
    UserDetails(),
    EventHome(),
    UserDetails()
  ];

  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: bottomNavigationTabBarView(),
      endDrawer: Container(),
    );
  }

  BottomNavigationBar bottomNavigationTabBarView() {
    const iconSize = 40.0;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: onTapTapped,
      currentIndex: indexTap, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle), label: 'Nuevo'),
        BottomNavigationBarItem(
            icon: new Icon(Icons.notifications), label: 'Notificaciones'),
        BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: new Icon(Icons.menu), label: 'Menu')
      ],
    );
  }
}
