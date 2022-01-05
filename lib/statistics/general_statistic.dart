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
  List<PieChartSectionData> pieChartSectionData = [
    PieChartSectionData(
        value: 10,
        title: "Juan Romo",
        color: Color(0xffa2663e)
    ),
    PieChartSectionData(
        value: 30,
        title: "Javier Alejandro Riofrío Luzcando",
        color: Colors.blue
    ),
    PieChartSectionData(
        value: 40,
        title: "Michelle Barriga",
        color: Colors.amberAccent
    ),
    PieChartSectionData(
        value: 10,
        title: "Nuaje Laboratoire",
        color: Colors.deepOrangeAccent
    ),
    PieChartSectionData(
        value: 10,
        title: "Javier Riofrio",
        color: Colors.cyanAccent
    ),
  ];
  List<Widget> _children() =>
      [EventAdd(user), NotificationUI(user), EventHome(widget.user)];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  ///Metodo para manajar el menu inferior del app
  void onTapTapped(int index) {
    index == 3
        ? _drawerKey.currentState!.openDrawer()
        : setState(() {
      indexTap = index;
    });
  }

  ///Metodo para inicializar los estados del aplicativo
  @override
  void initState() {
    super.initState();
    user = widget.user;
    // final doc = await FireStoreUtils.firestore.collection('users').get().then((value) => {
    //
    // pieChartSectionData.add(PieChartSectionData(
    //     value: value.size.toDouble(),
    //     title: value.docs.length.toString(),
    // color: Color(0xffa2663e)))
    //
    // });
    // print(pieChartSectionData);
  }

  ///Metodo build que crea la pantalla para las estadisticas de usuarios
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
    title: new Text('Estadisticas Generales'),
    elevation: 0.0,
    ),
      body: Column(
        children: [StreamBuilder<QuerySnapshot>(
            stream: FireStoreUtils.firestore.collection('users').snapshots(),
            builder: (context, snapshot) {

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
                      child:  ListTile(
                        leading: Icon(Icons.star ),
                        title: Text(snapshot.data!.docs[index]['firstName'] + " " + snapshot.data?.docs[index]['lastName']),
                      ),
                    );
                  },
                );
            }),
          Expanded(
            flex: 5,
              child: PieChart(PieChartData(
                  sections: pieChartSectionData,
                  centerSpaceRadius: 100,
                  sectionsSpace: 0
              ))
          )
        ],
      ),
    );
  }

  ///Metodo para obtener los futuros de los usuarios
  Future<List<User>> getUsers() async {
    final users = <User>[];
    final doc = await FireStoreUtils.firestore.collection('users').get().then((value) => {
      print(value)
    });

    return users;
  }

}

