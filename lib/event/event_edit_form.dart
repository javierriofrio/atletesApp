import 'dart:async';
import 'dart:io';

import 'package:atletes_sport_app/event/model/event.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;


class EventEditForm extends StatefulWidget {
  final DocumentSnapshot event;
  EventEditForm(this.event);

  @override
  _EventEditForm createState() => _EventEditForm();
}

class _EventEditForm extends State<EventEditForm> {
  File? image;
  late String imageUrl = 'https://i.imgur.com/sUFH1Aq.png';
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Event event = new Event(dateLimit: DateTime.now());
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  double pinPillPosition = PIN_VISIBLE_POSITION;
  late LatLng currentLocation;
  late LatLng destinationLocation;
  bool userBadgeSelected = false;
  File? _image;
  Stopwatch watch = Stopwatch();
  late List<Position> locationList = [];
  late Timer timer;
  bool startStop = true;
  String elapsedTime = '';

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];


  ///Inicializar valores para del evento seleccionado en la lista de eventos
  @override
  void initState() {
    super.initState();
    //setInitialLocation();

    _controllerDescription = TextEditingController(text: widget.event.get("description")) ;
    _controllerName = TextEditingController(text: widget.event.get("name")) ;
    _dateController = TextEditingController(text: widget.event.get("dateLimit").toDate().toString()) ;
    print(widget.event.get("eventID"));
    print(widget.event.get("listPositions"));
    widget.event.get("listPositions").forEach((value){
      polylineCoordinates.add(LatLng(value["latitude"],value["longitude"]));
    });
    print(widget.event.get("eventID"));
  }


  ///Método build que construye la pantalla para editar eventos
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ///Posisionamiento de la camara en la primera posision
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: polylineCoordinates[0]);

    return Form(
      child: new SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.event),
                    labelText: 'Nombre',
                  ),
                ),
                TextFormField(
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.event_note),
                    labelText: 'Descripcion',
                  ),
                ),
                TextFormField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: "Date",
                    icon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "Ingrese una fecha";
                    return null;
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 200.0,
                        child: Center(
                          child: Image.network(widget.event.get("photoURL")),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(elapsedTime, style: TextStyle(fontSize: 25.0)),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                              heroTag: "btn1",
                              backgroundColor: Colors.red,
                              onPressed: () => startOrStop(),
                              child: Icon(Icons.pause)),
                          SizedBox(width: 20.0),
                          FloatingActionButton(
                              heroTag: "btn2",
                              backgroundColor: Colors.green,
                              onPressed: () => saveLocation(), //resetWatch,
                              child: Icon(Icons.check)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  child: GoogleMap(
                      myLocationEnabled: true,
                      compassEnabled: true,
                      tiltGesturesEnabled: false,
                      markers: _markers,
                      polylines: _polylines,
                      mapType: MapType.normal,
                      initialCameraPosition: initialCameraPosition,
                      onMapCreated: onMapCreated),
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text("Guardar"),
                ),
              ],
            ),
          )),
    );
  }

  ///Método llamado para dibujar elementos necesarios dentro del mapa de googleMaps
  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setPolylines();
  }

  ///Método para dibujar la lineas de la ruta del eventos
  void setPolylines() async {
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });

  }

  ///Botón encargado para guardar los cambios para eventos editados
  void _submit() {
    event.listPositions = locationList;
    event.timestamp = watch.elapsedMilliseconds;
    FireStoreUtils.createNewEventUser(event);
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) => locationList.add(position));
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  saveLocation() {
    print(locationList);
  }

  ///Metodo para el timer vaya guardando las ubicaciones en el objeto evento
  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  ///Metodo para correr el timer
  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 10000), updateTime);
    });
  }

  ///Metodo para parar el timer
  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  ///Metodo para setear el tiempo transcurrido en el timer
  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  ///Metodo para transformar el tiempo en milisegundos a horas:minutos:segundos
  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

}