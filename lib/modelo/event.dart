import 'package:geolocator/geolocator.dart';

class Event {
  String name;
  String description;
  DateTime dateLimit;
  String photoURL;
  List<Position> listPositions;


  Event(
      {this.name = '',
      this.description = '',
      required this.dateLimit ,
      this.photoURL = '',
      this.listPositions = const []});


  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
        name: parsedJson['email'] ?? '',
        description: parsedJson['firstName'] ?? '',
        dateLimit: parsedJson['lastName'] ?? '',
        photoURL: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        listPositions: parsedJson['listPositions'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dateLimit': dateLimit,
      'photoURL': photoURL,
      'listPositions': listPositions,
    };
  }
}
