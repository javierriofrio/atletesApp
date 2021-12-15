import 'package:atletes_sport_app/notification/ui/notification_ui.dart';
import 'package:atletes_sport_app/statistics/general_statistic.dart';
import 'package:atletes_sport_app/user/user_details.dart';
import 'package:atletes_sport_app/user/user_find.dart';
import 'package:atletes_sport_app/user/user_list.dart';
import 'package:atletes_sport_app/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/event/event_list_home.dart';

import 'package:atletes_sport_app/ui/auth/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/services/helper.dart';
import 'package:atletes_sport_app/ui/auth/authentication_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import 'event/envet_find.dart';

class HomeEvents extends StatefulWidget {
  final User user;

  const HomeEvents({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _EventState();
}

class _EventState extends State<HomeEvents> {
  late User user;
  int indexTap = 0;

  List<Widget> _children() =>
      [EventAdd(), NotificationUI(user), EventHome(widget.user), UserDetails()];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void onTapTapped(int index) {
    index == 3
        ? _drawerKey.currentState!.openDrawer()
        : setState(() {
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
          key: _drawerKey,
          body: _children()[indexTap],
          bottomNavigationBar: bottomNavigationTabBarView(),
          drawer: Drawer(
              child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text('Mi Perfil'),
                onTap: (){
                  push(
                      context, UserDetails());
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today_outlined),
                title: Text('Crear Evento'),
                onTap: (){
                  push(
                      context, EventAdd());
                },
              ),
              ListTile(
                leading: Icon(Icons.find_in_page_outlined),
                title: Text('Buscar Evento'),
                onTap: (){
                  push(
                      context, EventFind());
                },
              ),
              ListTile(
                leading: Icon(Icons.circle_notifications),
                title: Text('Notificaciones'),
                onTap: (){
                  push(
                      context, NotificationUI(user));
                },
              ),
              ListTile(
                leading: Icon(Icons.auto_graph_outlined),
                title: Text('Estadisticas'),
                onTap: (){
                  push(
                      context, GeneralStatistic(user: user));
                },
              ),
              ListTile(
                leading: Icon(Icons.groups ),
                title: Text('Buscar Amigo'),
                onTap: (){
                  push(
                      context, UserFind(user));
                },
              )
            ],
          )),
        ));
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
      currentIndex: indexTap,
      // this will be set when a new tab is tapped
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
