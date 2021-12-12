import 'dart:async';
import 'dart:io';

import 'package:atletes_sport_app/modelo/event.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:atletes_sport_app/event/image_upload.dart';
import 'package:atletes_sport_app/event/timer.dart';

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

  /* Event? event;*/
  late String imageUrl = 'https://i.imgur.com/sUFH1Aq.png';

  /*String name = "";
  String description = "";
  DateTime? dateLimit;
  String photoURL = "";*/
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  double pinPillPosition = PIN_VISIBLE_POSITION;
  late LatLng currentLocation;
  late LatLng destinationLocation;
  bool userBadgeSelected = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
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
              /*onSaved: (value) {
                  name = value!;
              },*/
              decoration: const InputDecoration(
                icon: const Icon(Icons.event),
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              /*onSaved: (value) {
                description = value!;
              },*/
              decoration: const InputDecoration(
                icon: const Icon(Icons.event_note),
                labelText: 'Descripcion',
              ),
            ),
            BasicDateField(/*dateLimit*/),
            ImageUpload(/*event*/),
            NewStopWatch(/*event*/),
            SizedBox(
              width: 400 , // or use fixed size like 200
              height: 400,
              child: GoogleMap(
                myLocationEnabled: false,
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
            RaisedButton(
              onPressed: _submit,
              child: Text("submit"),
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
    /*print(event);*/
    // you can write your
    // own code according to
    // whatever you want to submit;
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");

/*
  DateTime? dateLimit;
  BasicDateField(this.dateLimit);
*/

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        /*onSaved: (value) {
          dateLimit = value!;
        },*/
        decoration: const InputDecoration(
          icon: const Icon(Icons.calendar_today),
          labelText: 'Fecha Limite',
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
