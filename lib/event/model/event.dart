import 'package:geolocator/geolocator.dart';

class Event {
  String eventID;
  String name;
  String description;
  DateTime dateLimit;
  String photoURL;
  int timestamp;
  String creator;
  List<Position> listPositions;


  Event(
      {
      this.eventID = '',
      this.name = '',
      this.description = '',
      required this.dateLimit ,
      this.photoURL = '',
      this.timestamp = 0,
      this.creator = '',
      this.listPositions = const []});


  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
      eventID: parsedJson['eventID'] ?? '',
        name: parsedJson['email'] ?? '',
        description: parsedJson['firstName'] ?? '',
        dateLimit: parsedJson['lastName'] ?? '',
        creator: parsedJson['creator'] ?? '',
        photoURL: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        timestamp: parsedJson['timestamp'] ?? parsedJson['timestamp'] ?? '',
        listPositions: parsedJson['listPositions'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'eventID': eventID,
      'name': name,
      'description': description,
      'dateLimit': dateLimit,
      'photoURL': photoURL,
      'creator': creator,
      'timestamp': timestamp,
      'listPositions': listPositions.map((i) => i.toJson()).toList(),
    };
  }
}
