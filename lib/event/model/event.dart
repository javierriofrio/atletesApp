import 'package:geolocator/geolocator.dart';

class Event {
  String name;
  String description;
  DateTime dateLimit;
  String photoURL;
  int timestamp;
  List<Position> listPositions;


  Event(
      {this.name = '',
      this.description = '',
      required this.dateLimit ,
      this.photoURL = '',
      this.timestamp = 0,
      this.listPositions = const []});


  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
        name: parsedJson['email'] ?? '',
        description: parsedJson['firstName'] ?? '',
        dateLimit: parsedJson['lastName'] ?? '',
        photoURL: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        timestamp: parsedJson['timestamp'] ?? parsedJson['timestamp'] ?? '',
        listPositions: parsedJson['listPositions'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dateLimit': dateLimit,
      'photoURL': photoURL,
      'timestamp': timestamp,
      'listPositions': listPositions.map((i) => i.toJson()).toList(),
    };
  }
}
