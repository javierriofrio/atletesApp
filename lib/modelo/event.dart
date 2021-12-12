import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String name;
  String description;
  DateTime dateLimit;
  String photoURL;
  List<dynamic> listPosition;


  Event(
      {this.name = '',
      this.description = '',
      required this.dateLimit ,
      this.photoURL = '',
      this.listPosition = new List()});


  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(
        name: parsedJson['email'] ?? '',
        description: parsedJson['firstName'] ?? '',
        dateLimit: parsedJson['lastName'] ?? '',
        photoURL: parsedJson['id'] ?? parsedJson['userID'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'dateLimit': dateLimit,
      'photoURL': photoURL,
    };
  }
}
