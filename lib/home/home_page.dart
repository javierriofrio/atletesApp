import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(child: Text('Home page en construccion'),),
    );
  }
}