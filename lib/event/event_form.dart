import 'dart:async';
import 'dart:io';

import 'package:atletes_sport_app/event/model/event.dart';
import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class EventForm extends StatefulWidget {
  @override
  _EventForm createState() => _EventForm();
}

class _EventForm extends State<EventForm> {
  File? image;

  late String imageUrl = 'https://i.imgur.com/sUFH1Aq.png';
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerDateLimit = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    setInitialLocation();
    polylinePoints = PolylinePoints();
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    return Form(
      child: new SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    event.name = value;
                  },
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.event),
                    labelText: 'Nombre',
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    event.description = value;
                  },
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.event_note),
                    labelText: 'Descripcion',
                  ),
                ),
                TextFormField(
                  onChanged: (val) {
                    event.dateLimit = selectedDate;
                  },
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)))!;

                    _dateController.text = date.toIso8601String();
                  },
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
                          child: _image == null
                              ? Image.network(imageUrl)
                              : Image.file(_image!),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () => pickImage(),
                      tooltip: "Elegir una imagen",
                      child: Icon(Icons.add_a_photo),
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
                SizedBox(
                  width: 400, // or use fixed size like 200
                  height: 400,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    polylines: _polylines,
                    markers: _markers,
                    mapType: MapType.normal,
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      setPolylines();
                    },
                  ),
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

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "<AIzaSyBxmNiWAYSxSnOV9LXSVZIpDM-E1mYa5pU>",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }

  void _submit() {
    event.listPositions = locationList;
    event.timestamp = watch.elapsedMilliseconds;
    FirebaseStorage.instance.ref('images/' + event.name)
        .putFile(_image!)
        .whenComplete(() async {
      try {
        imageUrl = await FirebaseStorage.instance.ref('images/' + event.name).getDownloadURL();
        event.photoURL = imageUrl;
      } catch (onError) {
        print("Error");
      }
      FireStoreUtils.createNewEvent(event);

    });
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this._image = imageTemporary);
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

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 10000), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

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