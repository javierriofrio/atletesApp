import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String eventName;
  String dateLimit;

  Notification(
      {this.eventName = '',
        this.dateLimit = ''});

  factory Notification.fromJson(Map<String, dynamic> parsedJson) {
    return Notification(
        eventName: parsedJson['eventName'] ?? '',
        dateLimit: parsedJson['dateLimit'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'dateLimit': dateLimit
    };
  }
}
