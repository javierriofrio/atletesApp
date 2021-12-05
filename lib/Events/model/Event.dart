import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Event extends Equatable{

  String id;
  String name;
  String description;
  String urlImage;
  DateTime dateLimit;
  //User userOwner;

  Event({
    Key key,
    @required this.name,
    @required this.description,
    @required this.urlImage,
    @required this.dateLimit

  });

  @override
  List<Object> get props => [name, description, urlImage, dateLimit];
}