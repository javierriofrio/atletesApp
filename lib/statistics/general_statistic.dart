import 'package:atletes_sport_app/event/description_event.dart';
import 'package:atletes_sport_app/event/event_add.dart';
import 'package:atletes_sport_app/event/event_find.dart';
import 'package:atletes_sport_app/notification/ui/notification_ui.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    List<PieChartSectionData> pieChartSectionData = [
    ];
    return Scaffold(
      appBar: new AppBar(
    title: new Text('Estadisticas Generales'),
    elevation: 0.0,
    ),
      body: Column(
        children: [StreamBuilder<QuerySnapshot>(
            stream: FireStoreUtils.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {

              List<QueryDocumentSnapshot> documentSnapshot = snapshot.data!.docs;
              for(QueryDocumentSnapshot doc in documentSnapshot) {

                final pieChart = PieChartSectionData(
                    value: 30,
                    title: "sss",
                    color: Color(0xffa2663e));

                pieChartSectionData.add(pieChart);
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount:snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      child: DescriptionEvent(snapshot.data!.docs[index]['firstName'], snapshot.data!.docs[index]['lastName'],
                          snapshot.data!.docs[index]['profilePictureURL']),
                    );
                  },
                );
            }),
          Expanded(
              flex: 5,
              child: PieChart(PieChartData(
                  sections: pieChartSectionData
              ))
          )
        ],
      ),
    );
  }

}

