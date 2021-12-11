import 'package:flutter/material.dart';
import 'gradient_back.dart';
import 'card_image_list.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bottomNavigationTabBarView();
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
      onTap: (value) {
        // Respond to item press.
      },
      currentIndex: 0, // this will be set when a new tab is tapped
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
