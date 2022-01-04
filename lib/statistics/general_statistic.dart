import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/event/event_find.dart';
import 'package:atletes_sport_app/notification/ui/notification_ui.dart';
import 'package:atletes_sport_app/user/user_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/model/user.dart';

class GeneralStatistic extends StatefulWidget {

final User user;
const GeneralStatistic({Key? key, required this.user}) : super(key: key);

@override
State createState() => _StatistictState();
}

class _StatistictState extends State<GeneralStatistic> {
  late User user;
  int indexTap = 0;

  List<Widget> _children() =>
      [EventAdd(user), NotificationUI(user), EventHome(widget.user)];

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
    // TODO: implement build

    List<PieChartSectionData> pieChartSectionData = [
      PieChartSectionData(
        value: 20,
        title: '20%',
        color: Color(0xffed733f),
      ),
      PieChartSectionData(
        value: 35,
        title: '35%',
        color: Color(0xff584f84),
      ),
      PieChartSectionData(
        value: 15,
        title: '15%',
        color: Color(0xffd86f9b),
      ),
      PieChartSectionData(
        value: 30,
        title: '30%',
        color: Color(0xffa2663e),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.blue,
        title: Text('Estadisticas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
      child:Container(
            child: ListView(
              children: [
              ],
            ),
          )
          ),
          Expanded(
            flex: 5,
              child: PieChart(PieChartData(
                  centerSpaceRadius: 100,
                  sectionsSpace: 0,
                  sections: pieChartSectionData
              ))
          )
        ],
      ),
    );
  }
}

