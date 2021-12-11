import 'package:flutter/material.dart';

class EventForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth',
              labelText: 'Dob',
            ),
          ),
          new Container(
            width: 150,
            child: new ElevatedButton(
              child: new Text(
                'Login',
                style: new TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () => {},
            ),
            margin: new EdgeInsets.only(
                top: 20.0
            ),
          )
        ],
      ),
    );
  }
}
