import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  late Map<String, bool> sports;

  CheckboxWidget(this.sports);

  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State<CheckboxWidget> {

  var holder_1 = [];

  getItems(){

    widget.sports.forEach((key, value) {
      if(value == true)
      {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[
      Expanded(
        child :
        ListView(
          children: widget.sports.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: widget.sports[key],
              activeColor: Colors.pink,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  widget.sports[key] = value!;
                });
              },
            );
          }).toList(),
        ),
      ),]);
  }
}