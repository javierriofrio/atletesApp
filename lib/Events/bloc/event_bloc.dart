
import 'package:atletes_sport_app/Events/model/Event.dart';
import 'package:bloc/bloc.dart';

class EventBloc {
  List<Event> _listEvents =  [
    Event(name: "event1", description: "event1", urlImage: "http://www.google.com", dateLimit: DateTime.parse("2021-01-01")),
    Event(name: "event1", description: "event2", urlImage: "http://www.google.com", dateLimit: DateTime.parse("2021-01-01")),
    Event(name: "event1", description: "event3", urlImage: "http://www.google.com", dateLimit: DateTime.parse("2021-01-01"))
  ];


  
}