import 'package:atletes_sport_app/user/user_details.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/event/event_list_home.dart';

import 'package:atletes_sport_app/ui/auth/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/services/helper.dart';
import 'package:atletes_sport_app/ui/auth/authentication_bloc.dart';

class HomeEvents extends StatefulWidget {
  final User user;

  const HomeEvents({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _EventState();
}

class _EventState extends State<HomeEvents> {
  late User user;
  int indexTap = 0;
  List<Widget> _children() => [
    EventAdd(),
    UserDetails(),
    EventHome(widget.user),
    UserDetails()
  ];

  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const LoginScreen(), false);
        }
      },
      child: Scaffold(
        body: _children()[indexTap],
        bottomNavigationBar: bottomNavigationTabBarView(),
      ),
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
